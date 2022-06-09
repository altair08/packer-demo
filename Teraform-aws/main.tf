terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.1.0"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "my_first_instance" {
    ami           = "${data.aws_ami.latest-ubuntu.id}"
    instance_type = "t2.micro"

     tags = {
    Name = "ExampleAppServerInstance"
  }
}

data "aws_ami" "latest-ubuntu" {
most_recent = true
owners = ["193213648434"] 
}


