#!/bin/sh


echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
service network restart

timedatectl set-timezone Asia/Tokyo
localectl set-locale LANG=en_US.UTF-8

echo 'cd /var/lib/jenkins' >> /home/vagrant/.bash_profile

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y java-1.8.0-openjdk jenkins
systemctl start jenkins
systemctl enable jenkins
sed -i "s/\(^.*jenkins.*\)\(\/bin\/false\)/\1\/bin\/bash/g" /etc/passwd
sh -c '/bin/echo -e "jenkins\njenkins" | passwd jenkins'