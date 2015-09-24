#!/bin/bash

set -e
sh /usr/local/bin/dind docker daemon &
sleep 5

exec "$@"