variable "project_name" {
    description = "Name of the project"
    default = "infraautomate"
    type = string

}
variable "environment" {
    description = "Name of the Envrionment"
    default = "dev"
    type = string 
}
variable "vpc_cidr" {
    description = "Cidr block for VPC"
    type = string
    default = "10.0.0.0/16"
}
variable "public_subnet_cidrs" {
description = "CIDR blocks for Public subnet"
type = list(string)
default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "AWS availability zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}