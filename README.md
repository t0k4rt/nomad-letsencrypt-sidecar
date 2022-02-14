## COMMAND:

docker run -v "$(pwd)/plop:/etc/letsencrypt/" -v "$(pwd)/certs:/certs" certbot-gandi -d domain.com --staging
