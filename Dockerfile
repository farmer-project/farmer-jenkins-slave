FROM docker:dind

RUN \
  apk add --update openssh sudo openjdk7-jre-base && \
  rm -rf /var/cache/apk/*

RUN \
  rc-update add sshd && \
  rc-status && \
  touch /run/openrc/softlevel && \
  sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
  /etc/init.d/sshd start && \
  /etc/init.d/sshd stop

RUN \
  adduser -D -s /bin/bash farmer && \
  echo -n 'farmer:farmer' | chpasswd && \
  echo 'farmer ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/farmer

EXPOSE 22

CMD ["/etc/init.d/sshd", "-D"]
