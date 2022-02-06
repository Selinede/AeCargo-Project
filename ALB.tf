

resource "aws_lb" "AeCargo-Alb1" {
  name               = "AeCargo-Alb1"
  load_balancer_type = "application"
  internal           = false
  subnet_mapping {
      subnet_id = aws_subnet.Public_Subnet1.id
  }

  subnet_mapping {
      subnet_id = aws_subnet.Public_Subnet2.id
  }

  tags = {
    "env"       = "dev"
    "createdBy" = "Selina"
  }
  security_groups = [aws_security_group.Alb-SecGrp.id]
}

resource "aws_security_group" "Alb-SecGrp" {
  name   = "allow-all-lb"
  vpc_id = aws_vpc.AeCargo_vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "env"       = "dev"
    "createdBy" = "Selina"
  }
}

resource "aws_lb_target_group" "Balancer-TarGrp" {
  name        = "Balancer-TarGrp"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.AeCargo_vpc.id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "web-listeners" {
  load_balancer_arn = aws_lb.AeCargo-Alb1.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Balancer-TarGrp.arn
  }
}