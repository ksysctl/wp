# WP
A WP Docker Project.

# Getting started
## Requirements
- [Docker](https://docs.docker.com/engine/installation/)
- [Docker compose](https://docs.docker.com/compose/install/)
- [Git](https://git-scm.com/downloads)

- State: ```Experimental```

- WP admin
By default your WP admin can be accesed from
https://cms.loc/mngr
Default username/pass: ```cms/cms```

- Mailcatcher UI:
Mailcatcher panel can be accesed from:
http://cms.loc:1080


## Setup
Run setup to initialize project, it will create an .env file in dev/deploy, it does not overwrite .env if already exists. Setup creates structure to handle DB files, modifies /etc/hosts to resolve your local server name.
```env
make setup
```

Before starting to build the project, modify the recently generated .env:

### Secrets
Generates WP keys/salts from:
https://api.wordpress.org/secret-key/1.1/salt/
```env
WP_AUTH_KEY=
WP_SECURE_AUTH_KEY=
WP_LOGGED_IN_KEY=
WP_NONCE_KEY=
WP_AUTH_SALT=
WP_SECURE_AUTH_SALT=
WP_LOGGED_IN_SALT=
WP_NONCE_SALT=
```

### PHP settings
Modify PHP settings if needed:
```
dev/deploy/php.ini
```

Modify XDEBUG setting if you need to enable/disable it:
```
dev/deploy/xdebug.ini
```

change localhost with your host ip, use ifconfig|ipconfig to get it.
```ini
xdebug.remote_host=localhost
```

if you need to enable it, set XDEBUG_ENABLED as 1 in your .env file.
```env
XDEBUG_ENABLED=0
```

## Build & intialize
finally build the image and import customized database.
```bash
make build
make restore
```

- [ ] *Remember [change](#plugins) akismet/recaptcha keys, defaults provided are for local environment use.*

# Docker 
Use Makefile to manage your images and containers.

### Build
Run build to initialize WP/DB, ensure that .env exists:
```bash
make build
```
o
```bash
make rebuild
```

### Logs
Run logs to show container logs, also, for specific WP logs can be found at wp-content/debug.log
if WORDPRESS_DEV_MODE is enabled (set as DEV), to see it enter to the container:
```bash
make logs
```

### Shell
Run shell to access to the container:
```bash
make shell
```

### Up/Down
Run up/down actions to start/stop container:
```bash
make up
```
o
```bash
make down
```

# Database

## Restore
Restore DB from live, loads an live.sql dump file in data/sql:
fixes urls in WP to use local dump imported from live
```bash
make restore
```

## Backup
Backup local DB, exports an local.sql dump file in data/sql:
```bash
make restore
```

# Develop tools

## XDebug
Config file launch.json for vs code.
```json
    "configurations": [
        {
            "name": "Xdebug for WP Project",
            "type": "php",
            "request": "launch",
            "port": 10000,
            "pathMappings": {
                "/var/www/html": "${workspaceFolder}/wordpress"
            }
        },
        {
            "name": "Launch currently open script",
            "type": "php",
            "request": "launch", 
            "program": "${file}", 
            "cwd": "${fileDirname}",
            "port": 10000 
        }
    ]
```


# Customize

### Change options
Change site options.
```bash
make change-option blogname='<blog name>' blogdesc='<blog description>'
```

### Change default admin
Create an new user with admin privileges to replace default `cms` that will be deleted.
```bash
make change-manager username=<username> email=<email> password=<password>
```

### Clean system
Clean tmp files, cache, database tables, it removes pending, trashed, auto-draft, orphaned posts/comments, etc.
```bash
make clean-system
```

### Update mail
Update mail service settings.
```bash
make mail-set
```

### Update smtp
Update smtp settings.
```bash
make mail-smtp
```

### Server name
Modify local server name running make:
ensure to set up your recaptcha and akismet key/secret for the new domain in .env.
```bash
make change-server domain=newserver.com
```

#### Apache
- Modify if needed dev/deploy/apache/default.conf for unsecure connections.
- Modify if needed dev/deploy/apache/default.ssl.conf for secure connections.
- Modify if needed dev/deploy/apache/security.conf for secutiry settings.
- Modify if needed dev/deploy/apache/http.conf for global settings.
```bash
make build
```

### Plugins
Generates keys/secrets from:
https://akismet.com/signup/
https://www.google.com/recaptcha/
```env
WP_AKISMET_KEY=
WP_RECAPTCHA_KEY=
WP_RECAPTCHA_SECRET=
```

#### Akismet.
```bash
make change-akismet akismet_key='<key>'
```
if new value is stored in .env then skip akismet_key parameter.
```bash
make change-akismet
```

#### Recaptcha.
Change Cerber Recaptcha API Key/Secret.
```bash
make change-recaptcha recaptcha_key='<key>' recaptcha_secret='<secret>'
```
if new values are stored in .env then skip recaptcha key|recaptcha secret parameter.
```bash
make change-akismet
```
