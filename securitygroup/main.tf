provider "aws" {
region = "us-east-1"
alias = "virginia"
}

provider "aws" {
region = "us-west-2"
alias = "oregon"
}

resource "aws_instance" "swiggy" {
tags = {
Name = "delivery"
}
provider = aws.virginia
ami = "ami-01b14b7ad41e17ba4"
instance_type = var.type["swigg"]
key_name = var.key
availability_zone = var.zone["swiggy"]
vpc_security_group_ids = aws_security_group.mysg.id
}

resource "aws_instance" "zomato" {
tags = {
Name = "delivery"
}
provider = aws.oregon
ami = "ami-043ab4148b7bb33e9"
instance_type = var.type["zomato"]
key_name = "de"
availability_zone = var.zone["zomato"]
root_block_device {
volume_size = 10
}
}

variable "type" {
type = map(string)
default = {
swigg = "t2.micro"
zomato = "t3.micro"
}
}
variable "key" {
type = string
default = "dem"
}
variable "zone" {
type = map(string)
default = {
swiggy = "us-east-1a"
zomato = "us-west-2b"
}
}
