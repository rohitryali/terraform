resource "aws_internet_gateway" "myigw" {
tags = {
name = "myigw"
}
vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "route" {
tags = {
Name = "myroute"
}
vpc_id = aws_vpc.myvpc.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.myigw.id
}
}
resource "aws_route_table_association" "asso1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.route.id
}

resource "aws_route_table_association" "asso2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.route.id
}

