#!/bin/sh

#
# Source: https://github.com/rtlong, https://gist.github.com/rtlong/6790049
# Usage: curl -L https://github.com/million12/docker-php-app-ssh/github-keys.sh | bash -s <github username>
#
set -e
set -u
IFS="$(printf '\n\t')"

mkdir -p ~/.ssh
if ! [[ -f ~/.ssh/authorized_keys ]]; then
  echo "Creating new ~/.ssh/authorized_keys"
  touch ~/.ssh/authorized_keys
fi

user=$1
keys=`curl https://api.github.com/users/$user/keys | grep -o -E "ssh-\w+\s+[^\"]+"`

for key in $keys; do
  echo $key
  grep -q "$key" ~/.ssh/authorized_keys || echo "$key" >> ~/.ssh/authorized_keys
done
