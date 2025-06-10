
# About

Setup an unatuhenticated SMTP Server, which can be used by containers in the same network to send mails
to an SSL configurted external SMTP server. This way this container acts as a SMTP relay for web
applications.

- Step 1: rebuild to change crednetials
- Step 2: restart with environment variables to change configuration 

# Compile

Add your credentials into `.env`. Then

```bash
podman compose --file compose.yml build
```

## Run

```bash
podman compose --file compose.yml up
```