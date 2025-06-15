resource "aws_vpc" "bookinfo_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "bookinfo-${lower(var.environment)}-vpc",
    Description = "VPC for creating learning app resources",
  }
}

