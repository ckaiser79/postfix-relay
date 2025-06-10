#!/bin/sh

#source /app/.env
test -z "${RELAY_SMTP_HOST}" && echo "RELAY_SMTP_HOST is not set" && exit 2
test -z "${RELAY_SMTP_FROM}" && echo "RELAY_SMTP_FROM is not set" && exit 2
test -z "${RELAY_SMTP_PASSWORD}" && echo "RELAY_SMTP_PASSWORD is not set" && exit 2
test -z "${LOCAL_SMTP_PORT}" &&  LOCAL_SMTP_PORT=2525

sed -i -e "s/^smtp /${LOCAL_SMTP_PORT} /g" /etc/postfix/master.cf

sed -i "s/{{RELAY_SMTP_FROM}}/${RELAY_SMTP_FROM}/" /etc/postfix/generic

sed -i "s/{{RELAY_SMTP_FROM}}/${RELAY_SMTP_FROM}/" /etc/postfix/sasl_passwd
sed -i "s/{{RELAY_SMTP_PASSWORD}}/${RELAY_SMTP_PASSWORD}/" /etc/postfix/sasl_passwd
sed -i "s/{{RELAY_SMTP_HOST}}/${RELAY_SMTP_HOST}/" /etc/postfix/sasl_passwd

sed -i "s/{{RELAY_SMTP_HOST}}/${RELAY_SMTP_HOST}/" /etc/postfix/main.cf

postmap /etc/postfix/sasl_passwd
postmap /etc/postfix/generic

# logfile umleiten
tail -n0 -F /var/log/mail.log &
postfix start-fg
