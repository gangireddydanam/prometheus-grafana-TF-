#bastion.tf

resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = "vpc-0b65b9f3a1da538e9"

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bastionsg"
  }
}

resource "aws_key_pair" "poc" {
  key_name   = "poc"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzHvV/w6XftjMmM89ZmIc3OA76qxYdbe3ZPxV43uSyXXEsVf7hjOj9gW47JxViZTxOw7OMLHOq8r6jo1wicsE6FM5XTc3OGUEOTq/Q40BHcL57yBL9SsYTlxRlc0VcAQAUdU/kZmzUfTVFe3nTaEcwbhuwlHyagzqEt8r126kLixBPiy83zvB0cPj2AnzWL3swZz/ZvwTuThg1gv5lR1poYG/z7PthVQRKIBdLYYQiXWNeMZyQNIxon3FDI0/jfaJ6N78c02HgJWuxzr+3mOXVIAAAYhga7kfqAFS1eL+Un6hZmpTDQF/nqkASH+XedeyWB9g6wxKC5uCFdxxdzafPtbFdGKzWFDbdlQ5+9sGRUUtsl9Lbnyv1xvx3KiOPyDeFDnqkVGnYyZSV9Uw8SuHsDhJt8QDVci+BPaaRdHWj43Vf3k3Lu/7KTSmgHV6ZNZ5x2hqU5FTRG0I42AY4hhNf0hM9UUEzC6jexZbWq+MNbaqR6UpXJy1gzS8RHoJJFvc= MaheswarGoud@DESKTOP-BL45D0D"
}

resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.type
  key_name               = aws_key_pair.poc.id
  vpc_security_group_ids = ["${aws_security_group.bastion-sg.id}"]
  subnet_id              = "subnet-0acc7c84bcc49a338"

  tags = {
    Name = "bastion"
  }
}