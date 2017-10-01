FROM centos:7.4.1708

RUN yum install -y openssh-server
RUN ssh-keygen -A

RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
# authorized_keys
# RUN chmod 600 /root/.ssh/authorized_keys

ADD run.sh /

ENTRYPOINT ["/run.sh"]
