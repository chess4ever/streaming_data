#!/usr/bin/env bash

mkdir -p /vagrant/sensor-input

#install java vm
sudo apt install openjdk-8-jre -y

#install elastic stack
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt-get update
sudo apt install elasticsearch
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service

sudo apt install kibana
sudo cp /vagrant/bootstrap/kibana.yml /etc/kibana/
sudo systemctl enable kibana.service
sudo systemctl start kibana.service

sudo apt install logstash
sudo cp /vagrant/bootstrap/logstash.yml /etc/logstash/
sudo cp /vagrant/bootstrap/main.conf /etc/logstash/conf.d/
sudo ln -s /vagrant/sensor-input /var/sensor-input
sudo systemctl enable logstash.service
sudo systemctl start logstash.service

#creating elasticsearch templates
/vagrant/bootstrap/elasticsearch-templates/template.sh
