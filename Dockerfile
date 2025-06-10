FROM alpine:latest

LABEL maintainer="Christian Kaiser <christian@hochsauerland.coach>"

COPY app /tmp/app

WORKDIR /tmp/app

# long runner in build
RUN apk update && apk add cyrus-sasl  cyrus-sasl-crammd5 cyrus-sasl-digestmd5 cyrus-sasl-login postfix
    
RUN mkdir /app && \
    cp -r etc/* /etc/ && \
    cat /etc/postfix/main.append.cf >> /etc/postfix/main.cf && \
    chown root:root /etc/postfix/sasl_passwd && \
    chmod 0600 /etc/postfix/sasl_passwd && \
    cp run-and-configure.sh /app/run-and-configure.sh && \
    chmod 755 /app/run-and-configure.sh && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /var/log/* && \
    rm -rf /tmp/app
    
# port 25 is not available on some linux systems
EXPOSE 2525

CMD ["/app/run-and-configure.sh"]
