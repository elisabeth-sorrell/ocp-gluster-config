#####################################################################################
###   OCP Master Cluster
#####################################################################################
module "ocp-master" {
  source                   = "./modules/cluster"
  key_name                 = "${var.key_name}"
  vpc_id                   = "${var.vpc_id}"
  subnet_azs               = "${var.subnet_azs}"
  cidr_blocks              = "${var.cidr_blocks}"
  cluster_ami_id           = "${var.ocp_master_cluster_ami_id}"
  cluster_name             = "${var.ocp_master_cluster_name}"
  cluster_port             = "${var.ocp_master_cluster_port}"
  cluster_protocol         = "${var.ocp_master_cluster_protocol}"
  cluster_instance_type    = "${var.ocp_master_cluster_instance_type}"
  cluster_root_volume_size = 50
}

# Volumes
module "ocp-master-volumes" {
  source                   = "./modules/disks/ocp-cluster"
  ocp_cluster_instance_ids = "${module.ocp-master.cluster_instance_ids}"
  ocp_cluster_name        = "${var.ocp_master_cluster_name}"
}

#####################################################################################
###   OCP Infra Cluster
#####################################################################################
module "ocp-infra" {
  source                   = "./modules/cluster"
  key_name                 = "${var.key_name}"
  vpc_id                   = "${var.vpc_id}"
  subnet_azs               = "${var.subnet_azs}"
  cidr_blocks              = "${var.cidr_blocks}"
  cluster_ami_id           = "${var.ocp_infra_cluster_ami_id}"
  cluster_name             = "${var.ocp_infra_cluster_name}"
  cluster_port             = "${var.ocp_infra_cluster_port}"
  cluster_protocol         = "${var.ocp_infra_cluster_protocol}"
  cluster_instance_type    = "${var.ocp_infra_cluster_instance_type}"
  cluster_root_volume_size = 50
}

# Volumes
module "ocp-infra-volumes" {
  source                   = "./modules/disks/ocp-cluster"
  ocp_cluster_instance_ids = "${module.ocp-infra.cluster_instance_ids}"
  ocp_cluster_name         = "${var.ocp_infra_cluster_name}"
}


#####################################################################################
###   Gluster Infra
#####################################################################################
module "gluster-infra" {
  source                   = "./modules/cluster"
  key_name                 = "${var.key_name}"
  vpc_id                   = "${var.vpc_id}"
  subnet_azs               = "${var.subnet_azs}"
  cidr_blocks              = "${var.cidr_blocks}"
  cluster_ami_id           = "${var.gluster_ami_id}"
  cluster_name             = "${var.gluster_infra_name}"
  cluster_port             = "${var.gluster_port}"
  cluster_protocol         = "${var.gluster_protocol}"
  cluster_instance_type    = "${var.gluster_instance_type}"
  cluster_root_volume_size = 500
}


#####################################################################################
###   Gluster
#####################################################################################
module "gluster" {
  source                   = "./modules/cluster"
  key_name                 = "${var.key_name}"
  vpc_id                   = "${var.vpc_id}"
  subnet_azs               = "${var.subnet_azs}"
  cidr_blocks              = "${var.cidr_blocks}"
  cluster_ami_id           = "${var.gluster_ami_id}"
  cluster_name             = "${var.gluster_name}"
  cluster_port             = "${var.gluster_port}"
  cluster_protocol         = "${var.gluster_protocol}"
  cluster_instance_type    = "${var.gluster_instance_type}"
  cluster_root_volume_size = 500
}

# Volumes
module "gluster-app-volumes" {
  source                   = "./modules/disks/gluster-app"
  gluster_instance_ids     = "${module.gluster.cluster_instance_ids}"
  gluster_name             = "${var.gluster_name}"
}


#####################################################################################
###   App Cluster Resources
#####################################################################################
resource "aws_instance" "app_cluster" {
  count              = "${var.app_amount}"
  ami                = "${var.app_ami_id}"
  instance_type      = "${var.app_instance_type}"
  availability_zone  = "${element(values(var.subnet_azs), count.index)}"
  key_name           = "${var.key_name}"
  subnet_id          = "${element(keys(var.subnet_azs), count.index)}"


  tags =  {
    Name = "${var.app_name}-${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.app_security_group.id}"]

  # The root block device
  root_block_device =  {
    # Do we need delete_on_termination set?
    volume_size     = "${var.app_root_volume_size}"
  }

  # The disk for /var/log
  ebs_block_device = {
    device_name    = "${var.app_name} /var/log Volume"
    volume_size    = "${var.app_log_volume_size}"
  }
}


######
#  App Security Group
######
resource "aws_security_group" "app_security_group" {
  name               = "${var.app_name} Security Group"
  description        = "Security group for the ${var.app_name} instances"

  ingress {
    from_port        = "${var.app_port}"
    to_port          = "${var.app_port}"
    protocol         = "${var.app_protocol}"
    cidr_blocks      = "${var.cidr_blocks}"
  }
}
