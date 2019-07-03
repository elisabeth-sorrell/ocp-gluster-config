########################################################################################################
########################################################################################################
# REQUIRED VARIBLES
# The following variables must be defined in order for terraform to run
########################################################################################################
########################################################################################################

variable "ssh_public_key" {
  description =  "Location of SSH key (local)"
}

variable "vpc_id" {
  description = "The ID of the VPC to launch resources into"
}

variable "subnet_azs" {
  description = "A map of availability zones to subnet IDs, where the keys are subnet IDs and the values are availability zones."
  type        = "map"
}

variable "cidr_blocks" {
  description = "A list of CIDR blocks for the three AZs"
  type        = "list"
}

variable "cluster_ami_id" {
  description = "The ID of the AMI to use for the cluster"
}

variable "cluster_name" {
  description = "Name of the instance cluster"
}

variable "cluster_port" {
  description = "Port of the cluster that we route traffic through."
}

variable "cluster_protocol" {
  description = "The protocol to reach the cluster through."
}

variable "cluster_instance_type" {
  description = "The type of instances that the cluster should be"
}
