provider "aws" {
region = "us-east-1"
}

resource "aws_instance" "app" {
  tags = {
    name = var.name
    env = var.env ? "dev" : "prod"
  }

  ami = var.ami
  instance_type = var.type[count.index]
  key_name = var.key
  availability_zone = var.zone[count.index]
  count = 2
  root_block_device {
    volume_size = var.size
  }
}

variable "name" {
  type = string
  default = "swiggy"
}
variable "env" {
  type = bool
  default = true
}
variable "ami" {
  type = string
  default = "ami-01b14b7ad41e17ba4"
}
variable "type" {
  type = list(string)
  default = ["t2.micro" , "t3.micro"]
}
variable "key" {
  type = string
  default = "demo"
}
variable "zone" {
  type = list(string)
  default = ["us-east-1a" , "us-east-1b"]
}
variable "size" {
  type = number
  default = 10
}

