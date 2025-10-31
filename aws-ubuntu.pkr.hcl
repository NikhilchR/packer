packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "ubuntu"{
 ami_name = "my-packer-ami"
 instance_type = "t2.micro"
 region = "us-east-1"
 source_ami_filter {
   filters = {
     name = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
     root-device-type = "ebs"
     virtualization-type = "hvm"
		}
   most_recent = true
   owners = [
			"099720109477"
		]
	}
 ssh_username = "ubuntu"
}
build {
 sources = [
		"source.amazon-ebs.ubuntu"
	]
}