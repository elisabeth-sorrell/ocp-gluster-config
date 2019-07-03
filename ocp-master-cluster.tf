
# Find our OCP Master cluster AMI
# data "aws_ami" "ocp-master" {
#   most_recent     = true
#   owners          = ["self"]
#   id  = "${var.ocp_master_cluster_ami_name}"
#
# }


################################################################################
#  Load Balancer Stuff
################################################################################
# Create our Application ALB
resource "aws_alb" "ocp_master_cluster_alb" {
  name               = "${var.ocp_master_cluster_name}"
  security_groups    = [
    "${aws_security_group.ocp_master_security_group.id}"
  ]
  subnets            = ["keys(var.subnet_azs)"]
}


# Create a target group for the alb
resource "aws_alb_target_group" "ocp_master_cluster_target_group" {
  name               = "${var.ocp_master_cluster_name}"
  port               = "${var.ocp_master_cluster_port}"
  protocol           = "${var.ocp_master_cluster_protocol}"
  vpc_id             = "${var.vpc_id}"

}

# Make a listener for the target group
resource "aws_alb_listener" "ocp_master_listener" {
  load_balancer_arn  = "${aws_alb.ocp_master_cluster_alb.arn}"
  port               = "${var.ocp_master_cluster_port}"
  protocol           = "${var.ocp_master_cluster_protocol}"

  default_action {
    target_group_arn = "${aws_alb_target_group.ocp_master_cluster_target_group.arn}"
    type             = "forward"
  }
}

# Attach the target group from the instances to itself
resource "aws_alb_target_group_attachment" "ocp_master_target_attachment" {
  count              = "${length(var.subnet_azs)}"
  target_group_arn   = "${aws_alb_target_group.ocp_master_cluster_target_group.arn}"
  target_id          = "${aws_instance.ocp_master_cluster[count.index].id}"
  port               = "${var.ocp_master_cluster_port}"
}


################################################################################
#  EC2 Instance Cluster and associated resources
################################################################################

# Create the OCP Master cluster instances
resource "aws_instance" "ocp_master_cluster" {
  count              = "${length(var.subnet_azs)}"
  ami                = "${var.ocp_master_cluster_ami_name}"
  instance_type      = "${var.ocp_master_cluster_instance_type}"
  availability_zone  = "${element(keys(var.subnet_azs), count.index)}"
  //cidr_block         = "${element(values(var.subnet_azs), count.index)}"
  key_name           = "${aws_key_pair.ocp_master_cluster_keypair.key_name}"


  tags =  {
    Name = "${var.ocp_master_cluster_name}-${count.index}"
  }

  vpc_security_group_ids = ["${aws_security_group.ocp_master_security_group.id}"]
}

resource "aws_key_pair" "ocp_master_cluster_keypair" {
  key_name      = "${var.ocp_master_cluster_name}"
  public_key    = "${file("${var.ssh_public_key}")}"
}

################################################################################
#  Security Groups
################################################################################
resource "aws_security_group" "ocp_master_security_group" {
  name               = "${var.ocp_master_cluster_name}-alb"
  description        = "Security group for the ${var.ocp_master_cluster_name} instances"

  ingress {
    from_port        = "${var.ocp_master_cluster_port}"
    to_port          = "${var.ocp_master_cluster_port}"
    protocol         = "${var.ocp_master_cluster_protocol}"
    cidr_blocks      = "${var.cidr_blocks}"
  }
}
