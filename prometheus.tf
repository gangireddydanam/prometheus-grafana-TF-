resource "aws_security_group" "promgrafana-sg" {
  name        = "promgrafana-sg"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = "vpc-0b65b9f3a1da538e9"

 
  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description     = "http from VPC"
    from_port       = 9090
    to_port         = 9090
    protocol        = "tcp"
    #security_groups = ["${aws_security_group.jenkins-sg.id}"]
    cidr_blocks = [ "0.0.0.0/0" ]

  }
  ingress {
    description     = "http from VPC"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    #security_groups = ["${aws_security_group.jenkins-sg.id}"]
    cidr_blocks = [ "0.0.0.0/0" ]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "promgrafana-sg"
  }
}

#prometheus-grafana_userdata

data "template_file" "promgrafana" {
  template = file("prometheus-grafana.sh")

}


resource "aws_instance" "promgrafana" {
  ami                    = var.ami
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.poc.id
  vpc_security_group_ids = ["${aws_security_group.promgrafana-sg.id}"]
  subnet_id              = "subnet-0acc7c84bcc49a338"
  user_data              = data.template_file.promgrafana.rendered



  tags = {
    Name = "promgrafana"
  }
}