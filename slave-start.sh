#!/bin/bash

set -ex


# Start the docker daemon
docker daemon &
sleep 10

# Start the ssh daemon
/usr/sbin/sshd -D
