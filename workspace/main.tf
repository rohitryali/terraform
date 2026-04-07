provider "aws" {
  region = "us-east-1"
}

locals {
  type = {
    default = "t3.micro"
    dev     = "t2.micro"
    prod    = "t3.medium"
  }
}

resource "aws_instance" "app" {
  tags = {
    Name = "${terraform.workspace}-server"
  }
  ami               = "ami-02dfbd4ff395f2a1b"
  instance_type     = local.type[terraform.workspace]
  key_name          = "d"
  availability_zone = "us-east-1a"
  root_block_device {
    volume_size = 20
  }
  count = 3
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = [tags]
  }
}
