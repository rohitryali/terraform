resource "aws_lb" "myalb" {
  name               = "myalb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
  security_groups    = [aws_security_group.mysg.id]

  tags = {
    Name = "myalb"
  }
}
resource "aws_lb_target_group" "mytg" {
  name     = "mytg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
resource "aws_lb_listener" "mylistener" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mytg.arn
  }
}
