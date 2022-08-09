resource "aws_vpc" "vpc_1" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.name_prefix}-vpc-1"
  }
}

resource "aws_vpc" "vpc_2" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.name_prefix}-vpc-2"
  }
}

resource "aws_vpc" "firewall" {
  cidr_block           = "10.3.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.name_prefix}-firewall"
  }
}
