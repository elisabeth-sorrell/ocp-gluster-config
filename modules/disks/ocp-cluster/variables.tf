########################################################################################################
########################################################################################################
# REQUIRED VARIBLES
# The following variables must be defined in order for this terraform module to run
########################################################################################################
########################################################################################################
variable "ocp_cluster_instance_ids" {
  description           = "A list of instance ids in the OCP cluster"
  type                  = "list"
}

variable "ocp_cluster_name" {
  description           = "The name of the ocp cluster"
}


########################################################################################################
########################################################################################################
# DEFAULT VARIABLES
# The following variables have reasonable defaults
########################################################################################################
########################################################################################################

variable "root_disk_size" {
  description           = "The size (in GB) of the disk to mount at ROOT"
  default               = 50
}

variable "root_device_name" {
  description           = "The device name of the root disk. See https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html#available-ec2-device-names for the recommended ones"
  default               = "/dev/sdf"
}

variable "log_disk_size" {
  description           = "The size (in GB) of the disk to mount at /var/log"
  default               = 50
}

variable "log_device_name" {
  description           = "The device EC2 mount name of the /var/log disk. See https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html#available-ec2-device-names for the recommended ones"
  default               = "/dev/sdg"
}

variable "docker_disk_size" {
  description           = "The size (in GB) of the disk to mount at /var/lib/docker"
  default               = 500
}

variable "docker_device_name" {
  description           = "The device EC2 mount name of the /var/lib/docker disk. See https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html#available-ec2-device-names for the recommended ones"
  default               = "/dev/sdh"
}
