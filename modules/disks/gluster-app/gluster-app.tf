#####################################################################################
#####################################################################################
### Data to look up the availability_zone per instance ID in the cluster
#####################################################################################
#####################################################################################
data "aws_instance" "gluster" {
  count                      = "${length(var.gluster_instance_ids}"
  instance_id                = "${element(var.gluster_instance_ids, count.index)}"
}


#####################################################################################
#####################################################################################
### Volumes for gluster instances that are for app cluster
#####################################################################################
#####################################################################################
# -- first volume
resource "aws_ebs_volume" "gluster_disks" {
  count                      = "${length(var.gluster_instance_ids)}"
  availability_zone          = "${element(data.aws_instance.gluster.availability_zone, count.index)}"
  // Size in GiB
  size                       = "${var.gluster_disk_size}"
  tags     =   {
    Name   =  "First ${var.gluster_name} volume ${count.index}"
  }
}
resource "aws_volume_attachment" "gluster_attachments" {
  count                      = "${length(var.gluster_instance_ids)}"
  device_name                = "${var.gluster_device_name}"
  instance_id                = "${element(var.gluster_instance_ids, count.index)}"
  volume_id                  = "${element(aws_ebs_volume.gluster_disks.*.id, count.index)}"
}
