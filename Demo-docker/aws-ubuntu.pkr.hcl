packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


source "amazon-ebs" "aws-ubuntu" {
  access_key    = "AKIASZ7DOJYZAHMHPIUY"
  secret_key    = "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"
  ami_name      = "packer-demo-docker-ansible-2"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "ami-0ee8244746ec5d6d4"
  ssh_username = "ubuntu"
  

}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.aws-ubuntu"
  ]

   provisioner "shell" {
    inline = ["sudo apt-get -y update","sudo apt-get -y install ansible"]
  }

  provisioner "ansible-local" {
    playbook_file   = "./docker_install.yaml"
  }
}

