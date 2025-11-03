packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "type_instance" {
  type = string
  default = "t2.micro"
}

source "amazon-ebs" "ubuntu" {
  ami_name          = "my-packer-ami"
  ami_description   = "Custom ubuntu AMI"
  instance_type     = var.type_instance
  region            = var.region
  ssh_username      = "ubuntu"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  tags = {
    Name        = "Packer Build Instance"
    Environment = "Development"
    Owner       = "DevOps Team"
  }

  ami_tags = {
    Name        = "Custom Ubuntu AMI"
    Environment = "Development"
    Owner       = "DevOps Team"
    Version     = "v1.0"
  }
}

build {
  name = "Custom Ubuntu AMI using packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "provisioner/setup.yml"
    user          = "ec2_user"
  }
}