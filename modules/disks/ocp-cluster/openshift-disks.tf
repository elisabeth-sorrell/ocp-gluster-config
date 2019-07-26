#####################################################################################
#####################################################################################
### Data to look up the availability_zone per instance ID in the cluster
#####################################################################################
#####################################################################################
data "aws_instance" "ocp_cluster" {
  count                      = "${length(var.ocp_cluster_instance_ids}"
  instance_id                = "${element(var.ocp_cluster_instance_ids, count.index)}"
}


#####################################################################################
#####################################################################################
### Volumes for OCP cluster instances
#####################################################################################
#####################################################################################
# -- ROOT volume
resource "aws_ebs_volume" "ocp_root_disks" {
  count                      = "${length(var.ocp_cluster_instance_ids)}"
  availability_zone          = "${element(data.aws_instance.ocp_cluster.availability_zone, count.index)}"
  // Size in GiB
  size                       = "${var.root_disk_size}"
  tags     =   {
    Name   =  "${var.ocp_cluster_name} ROOT volume ${count.index}"
  }
}
resource "aws_volume_attachment" "ocp_root_attachment" {
  count                      = "${length(var.ocp_cluster_instance_ids)}"
  device_name                = "${var.root_device_name}"
  instance_id                = "${element(var.ocp_cluster_instance_ids, count.index)}"
  volume_id                  = "${element(aws_ebs_volume.ocp_root_disks.*.id, count.index)}"
}


# --  log volume
resource "aws_ebs_volume" "ocp_log_disks" {
  count                      = "${length(var.ocp_cluster_instance_ids)}"
  availability_zone          = "${element(data.aws_instance.ocp_cluster.availability_zone, count.index)}"
  // Size in GiB
  size                       = "${var.log_disk_size}"
  tags     =   {
    Name   =  "${var.ocp_cluster_name} /var/log volume ${count.index}"
  }
}
resource "aws_volume_attachment" "ocp_log_attachment" {
  count                      = "${length(var.ocp_cluster_instance_ids)}"
  device_name                = "${var.log_device_name}"
  instance_id                = "${element(var.ocp_cluster_instance_ids, count.index)}"
  volume_id                  = "${element(aws_ebs_volume.ocp_log_disks.*.id, count.index)}"
}


# --  docker volume
resource "aws_ebs_volume" "ocp_docker_disks" {
  count                      = "${length(var.ocp_cluster_instance_ids)}"
  availability_zone          = "${element(data.aws_instance.ocp_cluster.availability_zone, count.index)}"
  // Size in GiB
  size                       = "${var.docker_disk_size}"
  tags     =   {
    Name   =  "${var.ocp_cluster_name} var/lib/docker volume ${count.index}"
  }
}
resource "aws_volume_attachment" "ocp_docker_attachments" {
  count                      = "${length(var.ocp_cluster_instance_ids)}"
  device_name                = "${var.docker_device_name}"
  instance_id                = "${element(var.ocp_cluster_instance_ids, count.index)}"
  volume_id                  = "${element(aws_ebs_volume.ocp_docker_disks.*.id, count.index)}"
}
