#!/bin/sh


echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
service network restart

timedatectl set-timezone Asia/Tokyo
localectl set-locale LANG=en_US.UTF-8

echo 'sudo cd /var/lib/jenkins' >> /home/vagrant/.bash_profile

useradd -s /bin/bash -d /var/lib/jenkins -m jenkins
sh -c '/bin/echo -e "jenkins\njenkins" | passwd jenkins'

yum install -y java-1.8.0-openjdk git

# check latest verison in https://github.com/docker/compose/blob/master/CHANGELOG.md
sh -c "curl -L https://github.com/docker/compose/releases/download/1.16.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
chmod +x /usr/local/bin/docker-compose
curl -sSL https://get.docker.com/ | sh
systemctl start docker.service
systemctl enable docker.service
usermod -a -G docker jenkins

su - jenkins
docker network create --driver bridge common_link
exit

systemctl stop docker.service
rm -rf /var/lib/docker