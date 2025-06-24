resource "aws_launch_template" "lt" {
  name_prefix   = "OKI-LT-"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
echo "<h1>Instance ID: $INSTANCE_ID</h1>" > /var/www/html/index.html
EOF
  )
}

resource "aws_lb_target_group" "tg" {
  name        = "OKI-TG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
}

resource "aws_lb" "alb" {
  name               = "OKI-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnets
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "OKI-ASG"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 2
  vpc_zone_identifier       = var.subnets
  target_group_arns         = [aws_lb_target_group.tg.arn]
  health_check_type         = "EC2"

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "OKI-instance"
    propagate_at_launch = true
  }
}