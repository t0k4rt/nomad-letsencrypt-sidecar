#!/bin/ash
# shellcheck shell=dash
set -e

# copy hook if it does not exists
# if [ ! -f "/etc/letsencrypt/renewal-hooks/deploy/haproxy_hook.sh" ]; then
#     mkdir -p /etc/letsencrypt/renewal-hooks/deploy
#     cp /config/haproxy_hook.sh /etc/letsencrypt/renewal-hooks/deploy/haproxy_hook.sh
#     chmod +x /etc/letsencrypt/renewal-hooks/deploy/haproxy_hook.sh
# fi
if [ "$DEBUG" = 1 ]; then
    ls -l /config
fi

certbot "$@"
