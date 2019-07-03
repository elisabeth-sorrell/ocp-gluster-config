#####################################################################################
###   OCP Master Cluster
#####################################################################################
module "ocp-master" {
  source                   = "./modules/cluster"
  ssh_public_key           = "${var.ssh_public_key}"
  vpc_id                   = "${var.vpc_id}"
  subnet_azs               = "${var.subnet_azs}"
  cidr_blocks              = "${var.cidr_blocks}"
  cluster_ami_id           = "${var.ocp_master_cluster_ami_id}"
  cluster_name             = "${var.ocp_master_cluster_name}"
  cluster_port             = "${var.ocp_master_cluster_port}"
  cluster_protocol         = "${var.ocp_master_cluster_protocol}"
  cluster_instance_type    = "${var.ocp_master_cluster_instance_type}"
}

#####################################################################################
###   OCP Infra Cluster
#####################################################################################
module "ocp-infra" {
  source                   = "./modules/cluster"
  ssh_public_key           = "${var.ssh_public_key}"
  vpc_id                   = "${var.vpc_id}"
  subnet_azs               = "${var.subnet_azs}"
  cidr_blocks              = "${var.cidr_blocks}"
  cluster_ami_id           = "${var.ocp_infra_cluster_ami_id}"
  cluster_name             = "${var.ocp_infra_cluster_name}"
  cluster_port             = "${var.ocp_infra_cluster_port}"
  cluster_protocol         = "${var.ocp_infra_cluster_protocol}"
  cluster_instance_type    = "${var.ocp_infra_cluster_instance_type}"
}

#####################################################################################
###   Gluster
#####################################################################################
module "gluster" {
  source                   = "./modules/cluster"
  ssh_public_key           = "${var.ssh_public_key}"
  vpc_id                   = "${var.vpc_id}"
  subnet_azs               = "${var.subnet_azs}"
  cidr_blocks              = "${var.cidr_blocks}"
  cluster_ami_id           = "${var.gluster_ami_id}"
  cluster_name             = "${var.gluster_name}"
  cluster_port             = "${var.gluster_port}"
  cluster_protocol         = "${var.gluster_protocol}"
  cluster_instance_type    = "${var.gluster_instance_type}"
}
