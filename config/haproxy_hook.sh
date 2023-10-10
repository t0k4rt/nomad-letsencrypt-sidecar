#!/bin/ash
# shellcheck shell=dash
set -e

DEST_DIR=/certs
DOMAINS=$(ls -d /etc/letsencrypt/live/*/ | sed 's|/etc/letsencrypt/live/||g; s|/||g')

upload_cert() {
    DOMAIN="$1"
    echo "Make full cert for $DOMAIN"
    cat "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" "/etc/letsencrypt/live/$DOMAIN/privkey.pem" > "/$DEST_DIR/$DOMAIN.pem"
    echo "Upload cert for $DOMAIN to consul"

    if [ -n "$CONSUL_HTTP_ADDR" ]; then
        echo "Will use consul endpoint: $CONSUL_HTTP_ADDR"
    fi
    consul kv put "HAPROXY_$DOMAIN" "@$DEST_DIR/$DOMAIN.pem"
}

echo "$DOMAINS" | while read -r line ; do upload_cert "$line" ; done
