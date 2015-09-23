FROM docker:dind

RUN \
  apk add --update bash openssh sudo openjdk7-jre-base git && \
  rm -rf /var/cache/apk/*

RUN \
  rc-update add sshd && \
  rc-status && \
  touch /run/openrc/softlevel && \
  sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
  ssh-keygen -t rsa1 -f /etc/ssh/ssh_host_key -N "" && \
  ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N "" && \
  ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""

RUN \
  adduser -D -s /bin/bash farmer && \
  echo -n 'farmer:farmer' | chpasswd && \
  echo 'farmer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/farmer

EXPOSE 22

ADD slave-start.sh /

CMD ["/slave-start.sh"]
