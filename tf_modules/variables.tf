variable "region" {
  description = "Region to spin up AWS instance"
  default = "us-east-1"
}

variable "instance_type" {
  description = "AWS instance type"
  default = "t2.micro"
}