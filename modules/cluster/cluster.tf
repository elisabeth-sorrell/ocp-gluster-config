
# Find our cluster AMI
# -- TODO: maybe we can make our own AMI with packer and
#    use this for using it.
# data "aws_" "cluster_ami" {
#   most_recent     = true
#   owners          = ["self"]
#   id  = "${var.cluster__name}"
#
# }


################################################################################
#  Load Balancer Stuff
################################################################################
# Create our Application ALB
resource "aws_alb" "cluster_alb" {
  name               = "${var.cluster_name}"
  security_groups    = [
    "${aws_security_group.security_group.id}"
  ]
  subnets            = ["keys(var.subnet_azs)"]
}


# Create a target group for the alb
resource "aws_alb_target_group" "cluster_target_group" {
  name               = "${var.cluster_name}"
  port               = "${var.cluster_port}"
  protocol           = "${var.cluster_protocol}"
  vpc_id             = "${var.vpc_id}"

}

# Make a listener for the target group
resource "aws_alb_listener" "listener" {
  load_balancer_arn  = "${aws_alb.cluster_alb.arn}"
  port               = "${var.cluster_port}"
  protocol           = "${var.cluster_protocol}"

  default_action {
    target_group_arn = "${aws_alb_target_group.cluster_target_group.arn}"
    type             = "forward"
  }
}

# Attach the target group from the instances to itself
resource "aws_alb_target_group_attachment" "target_attachment" {
  count              = "${length(var.subnet_azs)}"
  target_group_arn   = "${aws_alb_target_group.cluster_target_group.arn}"
  target_id          = "${aws_instance.cluster[count.index].id}"
  port               = "${var.cluster_port}"
}


################################################################################
#  EC2 Instance Cluster and associated resources
################################################################################

# Create the OCP Master cluster instances
resource "aws_instance" "cluster" {
  count              = "${length(var.subnet_azs)}"
  ami_id             = "${var.cluster_ami_id}"
  instance_type      = "${var.cluster_instance_type}"
  availability_zone  = "${element(keys(var.subnet_azs), count.index)}"
  //cidr_block         = "${element(values(var.subnet_azs), count.index)}"
  key_name           = "${aws_key_pair.cluster_keypair.key_name}"


  tags =  {
    Name = "${var.cluster_name}-${count.index}"
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
