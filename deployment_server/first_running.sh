#!/bin/sh


echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
service network restart

timedatectl set-timezone Asia/Tokyo
localectl set-locale LANG=en_US.UTF-8

echo 'cd /docker' >> /home/vagrant/.bash_profile
echo "alias docker-none='docker images | awk '\''\$1==\"<none>\" {print \$3}'\'' | xargs -Iimages docker rmi -f images'" >> /home/vagrant/.bashrc
echo "alias docker-killall='docker ps -a | awk '\''{print \$1}'\'' | tail -n +2 | xargs docker rm -f'" >> /home/vagrant/.bashrc
echo "function docker-exec() { docker exec -it \$1 sh; }" >> /home/vagrant/.bashrc

# check latest verison in https://github.com/docker/compose/blob/master/CHANGELOG.md
sh -c "curl -L https://github.com/docker/compose/releases/download/1.16.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
chmod +x /usr/local/bin/docker-compose
curl -sSL https://get.docker.com/ | sh
systemctl start docker.service
systemctl enable docker.service
usermod -a -G docker vagrant

su - vagrant
docker network create --driver bridge common_link
exit

systemctl stop docker.service
rm -rf /var/lib/docker