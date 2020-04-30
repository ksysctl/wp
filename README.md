# WP
A WP Docker Project.

# Getting started
## Requirements
- [Docker](https://docs.docker.com/engine/installation/)
- [Docker compose](https://docs.docker.com/compose/install/)
- [Git](https://git-scm.com/downloads)


- WP admin
By default your WP admin can be accesed from
https://cms.loc/mngr
Default username/pass: ```cms/cms```

- Mailcatcher UI:
Mailcatcher panel can be accesed from:
http://cms.loc:1080


## Setup
Run setup to initialize project, it will create an .env file in dev/deploy, it does not overwrite .env if already exists. Setup creates structure to handle DB files, and an entry to resolve your local server name.
```env
make setup
```

Before starting to build the project, modify the recently generated .env with:

### DB settings
```env
DB_CONTAINER=db_container_name
DB_PORT=3306
DB_HOST=db_host_name
DB_PASSWORD=db_password
DB_USERNAME=db_username
DB_NAME=db_name
DB_ROOT_PASSWORD=db_password_root
```

### WP settings
```env
WP_CONTAINER=wp_container_name
WP_PORT=80
WP_PORT_HTTPS=443
WP_DEV_MODE=DEV // set DEV to run in dev mode otherwise type anything for now e.g. PRODUCTION
WP_PROJECT=wp_title
WP_LIVE_SERVER=cms.com // change for production server name 
WP_LOCAL_SERVER=cms.loc // change for local server name 
WP_LIVE_URL=https://cms.com // change for production site url
WP_LOCAL_URL=http://cms.loc // change for production site url
WP_TABLE_PREFIX=prefix_
```

### Secrets
Generates WP unique keys and salts from
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

and build image.
```bash
make build
```

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

### Apache settings
- Modify if needed dev/deploy/apache/default.conf for unsecure connections.
- Modify if needed dev/deploy/apache/default.ssl.conf for secure connections.
- Modify if needed dev/deploy/apache/security.conf for secutiry settings.
- Modify if needed dev/deploy/apache/http.conf for global settings.

# Develop tools
## Docker 
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

### Change server name
Modify local server name running make:
ensure to set up your recaptcha and akismet key/secret for the new domain in .env.
```bash
make change-server domain=newserver.com
```

### Change default admin
Create an new user with admin privileges to replace default `cms` that will be deleted.
```bash
make change-manager username=<username> email=<email> password=<password>
```

### Change options
Change site options.
```bash
make change-option blogname='<blog name>' blogdesc='<blog description>'
```

### Change Akismet
Change WP Akismet API Key.
```bash
make change-akismet akismet_key='<key>'
```
if new value is stored in .env then skip akismet_key parameter.
```bash
make change-akismet
```

### Change Recaptcha
Change Cerber Recaptcha API Key/Secret.
```bash
make change-recaptcha recaptcha_key='<key>' recaptcha_secret='<secret>'
```
if new values are stored in .env then skip recaptcha key|recaptcha secret parameter.
```bash
make change-akismet
```

### Clean system
Clean tmp files, cache, database tables, it removes pending, trashed, auto-draft, orphaned posts/comments, etc.
```bash
make clean-system
```

### Update plugins
Update all available plugins.
```bash
make update-plugins
```

## Database

### Restore
Restore DB from live, loads an live.sql dump file in data/sql:
fixes urls in WP to use local dump imported from live
```bash
make restore
```

### Backup
Backup local DB, exports an local.sql dump file in data/sql:
```bash
make restore
```

# Notes

- Ensure to use strong passwords
https://strongpasswordgenerator.com/

- Set Akismet with your own API Key.
Goto WP > Settings > Akismet Anti-Spam or from CLI `make change-akismet`
https://akismet.com/signup/

- Set Recaptcha with your own Secret/Key.
Goto WP > WP Cerber > Anti-Spam > recaptcha
https://www.google.com/recaptcha/ or from CLI `make change-recaptcha`