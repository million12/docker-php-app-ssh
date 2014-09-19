#!/bin/bash

set -e
set -u

# Unlock 'www' account
PASS=$(pwgen -c -n -1 16)
echo "www:$PASS"  | chpasswd

# Make sure 'www' home directory exists...
mkdir -p /data/www && chown www /data/www

# Read passed to container ENV IMPORT_GITHUB_PUB_KEYS variable with coma-separated
# user list and add public key(s) for these users to authorized_keys on 'www' account.
for user in $(echo $IMPORT_GITHUB_PUB_KEYS | tr "," "\n"); do
  echo "user: $user"
  su www -c "/github-keys.sh $user"
done
