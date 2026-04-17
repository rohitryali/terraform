resource "aws_vpc" "myvpc" {
tags = {
Name = "MyVPC"
}
cidr_block = "10.0.0.0/24"
instance_tenancy = "default"
enable_dns_hostnames = "true"
}

