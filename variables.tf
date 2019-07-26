################################################################################
#  Provider variables
################################################################################
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

################################################################################
#  Common Variables across cluster
################################################################################

variable "key_name" {
  description = "The name of the keypair to associate with all cluster instances"
  type        = "string"
}
variable "vpc_id" {
  description = "The ID of the VPC to launch all clusters into"
  type        = "string"
}
variable "subnet_azs" {
  description = "A map of subnets to availability zones"
  type        = "map"
}
variable "cidr_blocks" {
  description = "A list of CIDR blocks to put into the security group for the clusters. Should put all CIDR blocks that the instances will be in, because they all need access to gluster"
  type        = "list"
}

################################################################################
#  OCP Master Variables
################################################################################
# ----
#  Required Variables
# ----
variable "ocp_master_cluster_ami_id" {
  description = "The AMI ID for the OCP Master cluster instances to launch"
  type        = "string"
}

# ----
#  Default Variables
# ----
variable "ocp_master_cluster_name" {
  description = "The name of the master OCP cluster"
  default     = "OCP-master"
}
variable "ocp_master_cluster_port" {
  description = "The port to access the master cluster through. Default is 443"
  default     = 443
}
variable "ocp_master_cluster_protocol" {
  description = "The protocol for the OCP master cluster. Default is HTTPS"
  default     = "HTTPS"
}
variable "ocp_master_cluster_instance_type" {
  description = "The instance type of the instances of the Master OCP cluster"
  default     = "M5.2XLarge"
}


################################################################################
#  OCP Infra Variables
################################################################################
# ----
#  Required Variables
# ----
variable "ocp_infra_cluster_ami_id" {
  description = "The AMI ID for the OCP Infra cluster instances to launch"
  type        = "string"
}

# ----
#  Default Variables
# ----
variable "ocp_infra_cluster_name" {
  description = "The name of the Infra OCP cluster"
  default     = "OCP-Infra"
}
variable "ocp_infra_cluster_port" {
  description = "The port to access the infra OCP cluster through. Default is 443"
  default     = 443
}
variable "ocp_infra_cluster_protocol" {
  description = "The protocol for the OCP infra cluster. Default is HTTPS"
  default     = "HTTPS"
}
variable "ocp_infra_cluster_instance_type" {
  description = "The instance type of the instances of the Infra OCP cluster"
  default     = "C5.2XLarge"
}


################################################################################
#  Gluster Variables
################################################################################
# ----
#  Required Variables
# ----
variable "gluster_ami_id" {
  description = "The AMI ID for the gluster instances to launch"
  type        = "string"
}

# ----
#  Default Variables
# ----
variable "gluster_name" {
  description = "The name of the Gluster instances associated with the OCP App clusters"
  default     = "OCP-Gluster"
}
variable "gluster_port" {
  description = "The port to access the master cluster through. Default is 443"
  default     = 443
}
variable "gluster_protocol" {
  description = "The protocol for the OCP master cluster. Default is HTTPS"
  default     = "HTTPS"
}
variable "gluster_instance_type" {
  description = "The instance type of the instances of the Master OCP cluster"
  default     = "M5.2XLarge"
}
variable "gluster_infra_name" {
  description = "The name of the gluster infrastructure instances for the OCP clusters"
  default     = "OCP-Gluster-Infra"
}

################################################################################
#  App Variables
################################################################################

variable "app_name" {
  description = "The name of the resources associated with the OCP App cluster"
  default     = "OCP-App"
}

variable "app_port" {
  description = "The port to access the OCP app cluster instances through. Default is 443"
  default     = 443
}

variable "app_protocol" {
  description = "The protocol for the OCP App cluster instances. Default is HTTPS"
  default     = "HTTPS"
}
