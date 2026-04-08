provider "aws" {
region = "us-east-1"
}

resource "aws_key_pair" "mykey" {
key_name = "key"
public_key = file("/home/ec2-user/.ssh/id_rsa.pub")
}
resource "aws_security_group" "mysg" {
name = "mysg-ec2"
ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
resource "aws_instance" "prov" {
tags = {
Name = "veeru"
}
ami = "ami-02dfbd4ff395f2a1b"
instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.mysg.id]
key_name = aws_key_pair.mykey.key_name
connection {
type = "ssh"
user = "ec2-user"
private_key = file("/home/ec2-user/.ssh/id_rsa")
host = self.public_ip
}
provisioner "remote-exec" {
inline = [
" sudo yum update -y" ,
"sudo yum install httpd -y" ,
"sudo systemctl start httpd"
]
}
provisioner "file" {
source = "/home/ec2-user/index.html"
destination = "/home/ec2-user/index.html"
}
provisioner "remote-exec" {
  inline = [
    "sudo cp index.html /var/www/html/"
  ]
}
provisioner "local-exec" {
  command = "echo 'my public ip = ${self.public_ip}' >> myip"
}
}
