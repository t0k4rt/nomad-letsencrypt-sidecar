FROM alpine:3.15

RUN apk update && \
    apk add py3-pip certbot consul nano

RUN pip3 install certbot-plugin-gandi

RUN mkdir -p /certs
RUN mkdir -p /config
ADD config /config/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
