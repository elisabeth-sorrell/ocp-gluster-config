########################################################################################################
########################################################################################################
# REQUIRED VARIBLES
# The following variables must be defined in order for this terraform module to run
########################################################################################################
########################################################################################################
variable "gluster_instance_ids" {
  description           = "A list of IDS of the gluster instances for the App cluster"
  type                  = "list"
}

variable "gluster_name" {
  description           = "The name for gluster resources"
}


########################################################################################################
########################################################################################################
# DEFAULT VARIABLES
# The following variables have reasonable defaults
########################################################################################################
########################################################################################################
variable "gluster_disk_size" {
  description           = "The size (in GB) of the disk to mount at ROOT"
  default               = 500
}

variable "gluster_device_name" {
  description           = "The device name of the first gluster disk. See https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html#available-ec2-device-names for the recommended ones"
  default               = "/dev/sdf"
}
