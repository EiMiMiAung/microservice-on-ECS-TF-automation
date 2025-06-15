# Standard Variables

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "environment" {
  description = "Development Environment"
  type        = string
}

# VPC Variables

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public subnet  - CIDR"
  type        = list(any)
}

variable "private_subnet_cidrs" {
  description = "Private subnet  - CIDR"
  type        = list(any)
}

