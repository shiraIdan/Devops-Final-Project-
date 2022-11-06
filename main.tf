terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    "Name" = "ShiraIdan-dev-vpc"
  }
}

resource "aws_internet_gateway" "in_gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "shira_in_gw"
  }
}

resource "aws_subnet" "Subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/27"
  tags = {
    "Name" = "ShiraIdan-k8s-subnet"

  }

}

resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.in_gw.id
}

# Setting up the network interface for machines 
resource "aws_network_interface" "IntCard" {
  subnet_id   = aws_subnet.Subnet.id
  private_ips = ["10.0.0.10"]

  tags = {
    "name" = "shira_IntCard"
  }
}

