# key pair (login)
resource "aws_key_pair" my_key {
  key_name   = "terraform-key"
  public_key = file("terraform-key.pub")
}

#vpc & security group
resource aws_default_vpc default {
  tags = {
    Name = "default"
  }
}
resource aws_security_group my_security_group {
  name        = "automatate-sg"
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
}

#ec2 instance
resource "aws_instance" "my_instance" {
  ami           = var.ec2_ami_id
  # count = 2
  for_each =  tomap({
    my-instance-automate-micro = "t2.micro"
    my-instance-automate-medium = "t2.medium"
  })
  #instance_type = var.ec2_instance_type
  instance_type = each.value
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  user_data = file("install-nginx.sh")
  
  root_block_device {
    volume_size = var.env == "prod" ? 20 : var.ec2_root_strorage_size
    volume_type = "gp3"
  }
  tags = {
    # Name = "my-instance-automate"
    Name = each.key
  }
}

