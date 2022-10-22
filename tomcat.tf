#jenkis-sg.tf

resource "aws_security_group" "tomcat-sg" {
  name        = "tomcat-sg"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = "vpc-0b65b9f3a1da538e9"

  ingress {
    description     = "ssh from VPC"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    #security_groups = ["${aws_security_group.tomcat-sg.id}"]
    cidr_blocks = [ "0.0.0.0/0" ]

  }
  ingress {
    description     = "http from VPC"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    #security_groups = ["${aws_security_group.tomcat-sg.id}"]
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
    Name = "tomcat-sg"
  }
}


#jenkinsuserdata

data "template_file" "userdata1" {
  template = file("userdata-tomcat.sh")

}


#jenkins instance

resource "aws_instance" "tomcat" {
  ami                    = var.ami
  instance_type          = var.type
  key_name               = aws_key_pair.poc.id
  vpc_security_group_ids = ["${aws_security_group.tomcat-sg.id}"]
  subnet_id              = "subnet-0acc7c84bcc49a338"
  user_data              = data.template_file.userdata1.rendered

  tags = {
    Name = "tomcat"
  }
}
