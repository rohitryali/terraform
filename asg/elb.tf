resource "aws_elb" "myelb" {
name = "myelb"
subnets = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
security_groups = [aws_security_group.mysg.id]
listener {
instance_port = 80
instance_protocol = "http"
lb_port = 80
lb_protocol = "http"
}
tags = {
Name = "myelb"
}
}
