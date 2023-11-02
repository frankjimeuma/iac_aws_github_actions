variable "vpc_cidr" {
  type = string
  description = "Enter a CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "cidr_public_subnet" {
    type = string
    description = "Enter s CIDR value for Subnet public"
    default = "10.0.1.0/24"
}

variable "cidr_private_subnet" {
    type = string
    description = "Enter s CIDR value for Subnet private"
    default = "10.0.2.0/24"
}

variable "securitygroup_name" {
    type = string
    description = "Enter the securitygroup name"
    # defaulth = "DemoClase05"
    default = "iac_aws_github_actions_SG"
}