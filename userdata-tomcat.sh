#!/bin/bash
cd /opt
sudo amazon-linux-extras install java-openjdk11 -y
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.68/bin/apache-tomcat-9.0.68.tar.gz
tar -xvzf apache-tomcat-9.0.68.tar.gz
chmod -R 755 apache-tomcat-9.0.68
cd apache-tomcat-9.0.68/bin/
./startup.sh
cd /opt
wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz
tar -xvzf node_exporter-1.4.0.linux-amd64.tar.gz
cd node_exporter-1.4.0.linux-amd64
nohup ./node_exporter &
