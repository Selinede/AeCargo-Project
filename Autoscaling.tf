

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}

resource "aws_security_group" "ec2-SecGrp" {
  name        = "ec2-SecGrp"
  description = "allow all ec2"
  vpc_id      = aws_vpc.AeCargo_vpc.id
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
    Name = "Selina"
  }
}

resource "aws_launch_configuration" "Launch-Config" {
  name          = "ecs_test"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
  iam_instance_profile        = aws_iam_instance_profile.ecs_service_roles.name
  key_name                    = "Jenkins-Java"
  security_groups             = [aws_security_group.ec2-SecGrp.id]
  associate_public_ip_address = true
  user_data                   = <<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER= web-cluster" >> /etc/ecs/ecs.config
EOF
}

resource "aws_autoscaling_group" "ecs-ASG-scalling" {
  name                      = "ecs-ASG-scalling"
  launch_configuration      = aws_launch_configuration.Launch-Config.name
  min_size                  = 3
  max_size                  = 4
  desired_capacity          = 3
  health_check_type         = "EC2"
  health_check_grace_period = 300
  vpc_zone_identifier       = [aws_subnet.Public_Subnet1.id, aws_subnet.Public_Subnet2.id]

  target_group_arns     = [aws_lb_target_group.Balancer-TarGrp.arn]
  protect_from_scale_in = true
  lifecycle {
    create_before_destroy = true
  }
}