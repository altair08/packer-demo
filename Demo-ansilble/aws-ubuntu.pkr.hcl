packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}


source "amazon-ebs" "aws-ubuntu" {
  ami_name      = "packer-demo-ngnix-ansible-${local.timestamp}"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "ami-0ee8244746ec5d6d4"
  ssh_username  = "ubuntu"
    tags = {
    Name = "Demo-Ami"
  }


}

build {
  name = "packer-demo"
  sources = [
    "source.amazon-ebs.aws-ubuntu"
  ]

  provisioner "shell" {
    inline = ["sudo apt-get -y update", "sudo apt-get -y install ansible"]
  }

  provisioner "ansible-local" {
    playbook_file = "./playbook.yaml"
  }
}

