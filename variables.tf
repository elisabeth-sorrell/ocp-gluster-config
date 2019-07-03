########################################################################################################
########################################################################################################
# REQUIRED VARIBLES
# The following variables must be defined in order for terraform to run
########################################################################################################
########################################################################################################

variable "aws_access_key_id" {
  type        = "string"
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  type        = "string"
  description = "AWS secret access key"
}

variable "aws_region" {
  type        = "string"
  description = "AWS region"
}

variable "ssh_public_key" {
  description =  "Location of SSH key (local)"
}

variable "ssh_private_key" {
  description = "Location of SSH private key"
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

variable "ocp_master_cluster_ami_name" {

}


########################################################################################################
########################################################################################################
# DEFAULT VARIBLES
# The following variables have reasonable defaults
########################################################################################################
########################################################################################################

#   ----
#   OCP Master Cluster variables
#   ----
variable "ocp_master_cluster_name" {
  description = "name of the OCP master cluster"
  default     = "ocp-master-cluster"
}

variable "ocp_master_cluster_port" {
  description = "Port of the OCP master cluster that we route traffic through."
  default     = "443"
}

variable "ocp_master_cluster_protocol" {
  description = "The protocol to reach the OCP cluster through."
  default     = "HTTPS"
}

variable "ocp_master_cluster_instance_type" {
  description = "The type of instances that the OCP master cluster should be"
  default     = "M5.2XLarge"
}
