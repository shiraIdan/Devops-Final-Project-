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
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "ShiraIdan-dev-vpc"
  }
}

resource "aws_subnet" "Subnet" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.0.0.0/27"
  tags = {
    "Name" = "ShiraIdan-k8s-subnet"

  }

}
