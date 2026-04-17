resource "aws_launch_template" "my_template" {
name = "my_template"
image_id = "ami-098e39bafa7e7303d"
instance_type = "t2.micro"
key_name = "demo"
vpc_security_group_ids = [aws_security_group.mysg.id]

user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo chmod 777 /var/www/html
    echo "<html><body><h1>Welcome to Terraform Scaling.</h1></body></html>" | tee /var/www/html/index.html
  EOF
  )
}
