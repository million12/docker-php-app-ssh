#!/bin/bash

set -e
set -u

# Unlock 'www' account
PASS=$(pwgen -c -n -1 16)
echo "www:$PASS" | chpasswd

# Make sure 'www' home directory exists...
mkdir -p /data/www && chown www /data/www

if [ -z "${IMPORT_GITHUB_PUB_KEYS+xxx}" ] || [ -z "${IMPORT_GITHUB_PUB_KEYS}" ]; then
  echo "WARNING: env variable \$IMPORT_GITHUB_PUB_KEYS is not set. Please set it to have access to this container via SSH."
else
  # Read passed to container ENV IMPORT_GITHUB_PUB_KEYS variable with coma-separated
  # user list and add public key(s) for these users to authorized_keys on 'www' account.
  for user in $(echo $IMPORT_GITHUB_PUB_KEYS | tr "," "\n"); do
    echo "user: $user"
    su www -c "/github-keys.sh $user"
  done
fi
