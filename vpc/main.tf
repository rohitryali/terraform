provider "aws" {
region = "us-east-1"
}

resource "aws_vpc" "vpc_1" {
tags = {
Name = "terraform_vpc"
}
cidr_block = "10.0.0.0/23"
instance_tenancy = "default"
enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
vpc_id = aws_vpc.vpc_1.id
tags = {
Name = "terraform_public_subnet"
}
availability_zone = "us-east-1a"
cidr_block = "10.0.0.0/24"
map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
vpc_id = aws_vpc.vpc_1.id
tags = {
Name = "terraform_private_subnet"
}
availability_zone = "us-east-1b"
cidr_block = "10.0.1.0/25"
map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "my_igw" {
tags = {
Name = "terraform-igw"
}
vpc_id = aws_vpc.vpc_1.id
}

resource "aws_route_table" "public_route" {
tags = {
Name = "terraform-public_route"
}
vpc_id = aws_vpc.vpc_1.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.my_igw.id
}
}

resource "aws_route_table_association" "public_rt" {
subnet_id = aws_subnet.public_subnet.id
route_table_id = aws_route_table.public_route.id
}

resource "aws_eip" "nat_eip" {
domain = "vpc"
tags = {
Name = "nat-eip"
}
}

resource "aws_nat_gateway" "nat" {
subnet_id = aws_subnet.public_subnet.id
allocation_id = aws_eip.nat_eip.id
tags = {
Name = "nat_gw"
}
depends_on = [aws_internet_gateway.my_igw]
}

resource "aws_route_table" "private_route" {
tags = {
Name = "terraform-private_route"
}
vpc_id = aws_vpc.vpc_1.id
route {
cidr_block = "0.0.0.0/0"
nat_gateway_id = aws_nat_gateway.nat.id
}
}

resource "aws_route_table_association" "private_rt" {
subnet_id = aws_subnet.private_subnet.id
route_table_id = aws_route_table.private_route.id
}

