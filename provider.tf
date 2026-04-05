provider "aws" {
region = "us-east-1"
}

resource "aws_instance" "my-ec2" {
tags = {
name = "ec2-1"
env = "devops"
}
ami = "ami-01b14b7ad41e17ba4"
instance_type = "t2.micro"
key_name = "demo"
availability_zone = "us-east-1c"
root_block_device {
  volume_size = 15
}
count = 2
}
