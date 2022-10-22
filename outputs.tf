output "bastion-ip" {
  value= aws_instance.bastion.public_ip
}
output "tomcat" {
  value= aws_instance.tomcat.public_ip
}
output "promgrafana" {
  value= aws_instance.promgrafana.public_ip
}