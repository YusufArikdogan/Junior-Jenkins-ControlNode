terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "aws_access" {
  name = "awsrole-${var.user}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/IAMFullAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess"]

}

resource "aws_iam_instance_profile" "ec2-profile" {
  name = "junior-level-profile-${var.user}"
  role = aws_iam_role.aws_access.name
}

data "aws_ami" "al2023" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "junior-level-server" {
  ami = data.aws_ami.al2023.id
  instance_type = var.instancetype
  key_name      = var.mykey
  vpc_security_group_ids = [aws_security_group.junior-level-sec-gr.id]
  iam_instance_profile = aws_iam_instance_profile.ec2-profile.name
  tags = {
    Name = var.tag
  }
  user_data = file("junior.sh")
}

resource "aws_security_group" "junior-level-sec-gr" {
  name = "${var.junior-level-sg}-${var.user}"
  tags = {
    Name = var.junior-level-sg
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ssh-connection-command" {
  value = "ssh -i ${var.mykey}.pem ec2-user@${aws_instance.junior-level-server.public_ip}"
}
output "junior-level-server" {
  value = "http://${aws_instance.junior-level-server.public_dns}:8080"
}
output "jenkins-initialadminpasswordpath" {
  value = "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
}