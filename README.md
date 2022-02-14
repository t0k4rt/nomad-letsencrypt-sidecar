## COMMAND:

docker run -v "$(pwd)/letsencrypt:/etc/letsencrypt/" -v "$(pwd)/certs:/certs" certbot-gandi -d domain.com --staging
