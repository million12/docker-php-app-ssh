#!/bin/sh

#
# Source: https://github.com/rtlong, https://gist.github.com/rtlong/6790049
# Usage: /github-keys.sh | bash -s <github username>
#

IFS="$(printf '\n\t')"

user=$1
api_call=$(curl -v https://api.github.com/users/$user/keys 2>&1)
rate_limit=$(echo $api_call | grep -o -E 'X-RateLimit-Remaining:\s\d+' | grep -o -E '\d+')
keys=$(echo $api_call | grep -o -E 'ssh-\w+\s+[^\"]+')

if [ $rate_limit -eq 0 ];
  then
    echo "WARNING: Github API rate limit exceeded. No key(s) added to `whoami` account."
  else
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
fi