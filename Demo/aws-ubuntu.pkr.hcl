packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}



source "amazon-ebs" "aws-ubuntu" {
  ami_name      = "packer-demo-ngnix-file"
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
    script = "./app.sh"
  }

   provisioner "file" {
    source = "index.html"
    destination = "/tmp/"
  }

   provisioner "shell" {
    inline = ["sudo cp /tmp/index.html /var/www/html/"]
  }
}
