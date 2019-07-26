################################################################################
#  EC2 Instance Cluster and associated resources
################################################################################

# Create the OCP Master cluster instances
resource "aws_instance" "cluster" {
  count              = "${length(var.subnet_azs)}"
  ami                = "${var.cluster_ami_id}"
  instance_type      = "${var.cluster_instance_type}"
  availability_zone  = "${element(keys(var.subnet_azs), count.index)}"
  //cidr_block         = "${element(values(var.subnet_azs), count.index)}"
  key_name           = "${aws_key_pair.cluster_keypair.key_name}"
  subnet_id          = "${element()}"


  tags =  {
    Name = "${var.cluster_name}-${count.index}"
  }

  # The root block device
  root_block_device =  {
    # Do we need delete_on_termination set?
    volume_size     = "${var.cluster_root_volume_size}"
  }

  vpc_security_group_ids = ["${aws_security_group.security_group.id}"]
}

resource "aws_key_pair" "cluster_keypair" {
  key_name      = "${var.cluster_name}"
  public_key    = "${file("${var.ssh_public_key}")}"
}

################################################################################
#  Security Groups
################################################################################
resource "aws_security_group" "security_group" {
  name               = "${var.cluster_name}-alb"
  description        = "Security group for the ${var.cluster_name} instances"

  ingress {
    from_port        = "${var.cluster_port}"
    to_port          = "${var.cluster_port}"
    protocol         = "${var.cluster_protocol}"
    cidr_blocks      = "${var.cidr_blocks}"
  }
}
