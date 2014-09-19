#!/bin/bash

#mkdir -p /data/www/.ssh && touch /data/www/.ssh/authorized_keys
#chmod 700 /data/www/.ssh && chmod 600 /data/www/.ssh/authorized_keys
#chown -R www:www /data/www/.ssh

set -e
set -u

PASS=$(pwgen -c -n -1 16)
echo "www:$PASS"  | chpasswd

curl -L https://github.com/million12/docker-php-app-ssh/github-keys.sh | bash -s $IMPORT_GITHUB_PUB_KEYS
