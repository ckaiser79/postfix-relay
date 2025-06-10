FROM alpine:latest

LABEL maintainer="Christian Kaiser <christian@hochsauerland.coach>"

COPY app /tmp/app

WORKDIR /tmp/app

# long runner in build
RUN apk update && apk add cyrus-sasl  cyrus-sasl-crammd5 cyrus-sasl-digestmd5 cyrus-sasl-login postfix
    
RUN cp -r etc/* /etc/ && \
    cat /etc/postfix/main.append.cf >> /etc/postfix/main.cf && \
    chown root:root /etc/postfix/sasl_passwd && \
    chmod 0600 /etc/postfix/sasl_passwd && \
    cp run-and-configure.sh /app/run-and-configure.sh && \
    chmod 755 /app/run-and-configure.sh && \
    rm -rf /tmp/app && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/dpkg/* && \
    rm -rf /var/log/* && \
    rm -rf /var/tmp/*

# port 25 is not available on some linux systems
EXPOSE 2525

CMD ["/app/run-and-configure.sh"]
