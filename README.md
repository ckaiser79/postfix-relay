
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

## Official build

See github workflow:

```bash
RELEASE=$(date +%Y%m%d-%H%M%S) # for snapshots or 1.0.0 for releases
podman build . --file Dockerfile --tag ckaiser79/postfix-relay:$RELEASE

# check
podman image ls | grep postfix
```

# Run

```bash
# listen on port 2525 by default
podman compose --file compose.yml up -d
```

## Configuration

| Key | Description | Default |
|:----|:----|:----|
| `RELAY_SMTP_FROM` | Sender, which is used when authenticating on relay smtp server. | |
| `RELAY_SMTP_PASSWORD` | Password, which is used when authenticating on relay smtp server. | |
| `RELAY_SMTP_HOST` | *hostname:port*, which is used when authenticating on relay smtp server. | |
| `LOCAL_SMTP_PORT` | Port, where postfix SMTP listens. | 2525 |

# Usefull

- `grep -v -e '^#'  main.cf | grep -v '^$'` - grep active configuration keys    