# key pair (login)
resource "aws_key_pair" my_key {
  key_name   = "${var.env}-infra-key"
  public_key = file("terraform-key.pub")

  tags = {
    Name        = var.env
  }
}

#vpc & security group
resource aws_default_vpc default {
  tags = {
    Name = "default"
  }
}
resource aws_security_group my_security_group {
  name        = "${var.env}-infra-app-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_default_vpc.default.id
 
#inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
#outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.env}-infra-app-sg"
    }
}

#ec2 instance
resource "aws_instance" "my_instance" {
  ami           = var.ec2_ami_id
  count = var.instance_count
  instance_type = var.instance_type
  
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
 
  root_block_device {
    volume_size = var.env == "prod" ? 20 : 10
    volume_type = "gp3"
  }
  tags = {
    Name = "${var.env}-infra-app-instance"
    environment = var.env
  }
}

