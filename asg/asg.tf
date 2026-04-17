resource "aws_autoscaling_group" "myasg" {
name = "myasg"
launch_template {
id = aws_launch_template.my_template.id
version = "$Latest"
}
vpc_zone_identifier = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
target_group_arns = [aws_lb_target_group.mytg.arn]
desired_capacity = 3
min_size = 2
max_size =5
}
