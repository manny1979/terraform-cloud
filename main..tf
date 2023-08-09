terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

terraform {
  cloud {
    organization = "chrisline_engineering"

    workspaces {
      name = "testing_workspace"
    }
  }
}

resource "aws_instance" "web" {
  ami = var.ami[1]
  instance_type = var.instance_type[1]
  associate_public_ip_address = var.associate_public_ip_address
  
}

resource "aws_vpc" "master" {
  cidr_block       = var.aws_vpc[1]
  instance_tenancy = "default"

  tags = {
    Name = var.tags[2]
  }
}

variable "aws_vpc" {
  description = "this is the cidr block for this vpc"
  default = ["10.0.0.0/16","20.0.0.0/16","30.0.5.0/16"]
}

variable "tags" {
  default = ["solo","nasa","manny"]

}

variable "ami" {
  description = "this is the ami for this instance"
  default = ["ami-0f34c5ae932e6f0e4","ami-024fc608af8f886bc","ami-024fc608af8f886bj"]
  
}

variable "instance_type" {
  type = list
  default = ["t2.micro","t2.nano","t2.medium"]
  
}

variable "associate_public_ip_address" {
  type = bool
  default = true
}

output "cidr_block" {
  value = aws_vpc.master
}
