#!/bin/sh

#source /app/.env
test -z "${RELAY_SMTP_HOST}" && echo "RELAY_SMTP_HOST is not set" && exit 1
test -z "${RELAY_SMTP_FROM}" && echo "RELAY_SMTP_FROM is not set" && exit 1
test -z "${RELAY_SMTP_PASSWORD}" && echo "RELAY_SMTP_PASSWORD is not set" && exit 1

sed -i "s/{{RELAY_SMTP_FROM}}/${RELAY_SMTP_FROM}/" /etc/postfix/generic

sed -i "s/{{RELAY_SMTP_FROM}}/${RELAY_SMTP_FROM}/" /etc/postfix/sasl_passwd
sed -i "s/{{RELAY_SMTP_PASSWORD}}/${RELAY_SMTP_PASSWORD}/" /etc/postfix/sasl_passwd
sed -i "s/{{RELAY_SMTP_HOST}}/${RELAY_SMTP_HOST}/" /etc/postfix/sasl_passwd

sed -i "s/{{RELAY_SMTP_HOST}}/${RELAY_SMTP_HOST}/" /etc/postfix/main.cf

postmap /etc/postfix/sasl_passwd
postmap /etc/postfix/generic

postfix start-fg
