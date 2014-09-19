#!/bin/sh

#
# Source: https://github.com/rtlong, https://gist.github.com/rtlong/6790049
# Usage: /github-keys.sh | bash -s <github username>
#

IFS="$(printf '\n\t')"

user=$1
keys=`curl -s https://api.github.com/users/$user/keys | grep -o -E "ssh-\w+\s+[^\"]+"`

echo "Importing $user's GitHub pub key(s) to `whoami` account..."

mkdir -p ~/.ssh
if ! [[ -f ~/.ssh/authorized_keys ]]; then
  echo "Creating new ~/.ssh/authorized_keys"
  touch ~/.ssh/authorized_keys
fi

for key in $keys; do
  echo "Imported GitHub $user key: $key" 
  grep -q "$key" ~/.ssh/authorized_keys || echo "$key ${user}@github" >> ~/.ssh/authorized_keys
done
