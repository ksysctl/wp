# WP
A WP Docker Project.

# Getting started
## Requirements
- [Docker](https://docs.docker.com/engine/installation/)
- [Docker compose](https://docs.docker.com/compose/install/)
- [Git](https://git-scm.com/downloads)

By default your WP admin can be accesed from:
https://cms.loc/mngr


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
WP_USERNAME=wp_username
WP_PASSWORD=wp_password
WP_PROJECT=wp_title
WP_LIVE_SERVER=cms.com // change for production server name 
WP_LOCAL_SERVER=cms.loc // change for local server name 
WP_LIVE_URL=https://cms.com // change for production site url
WP_LOCAL_URL=http://cms.loc // change for production site url
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

Modify XDEBUG settings if needed:
```
dev/deploy/xdebug.ini
```

ensure that XDEBUG_ENABLED is set as 1 if you want to enable xdebug, also uncomment:
```php.ini
;zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20180731/xdebug.so
;xdebug.remote_enable=1
;xdebug.remote_autostart=1
;xdebug.remote_host=192.168.1.3
```

set remote_host with your host internal ip and zend_extension with
absolute path of xdebug.so, to locate it in the container run:
```bash
find /usr/local/lib/php/extensions/ -name xdebug.so
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
ensure to set up your recaptcha and askimet key/secret for the new domain, then start WP container,
once server is up, run change command, e.g.
```bash
<change key/secret from WP>

make up
make change dns=newserver.com
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

- Set Askimet with your own API Key.
Goto WP > Settings > Askimet Anti-Spam
https://akismet.com/signup/

- Set Recaptcha with your own Secret/Key.
Goto WP > WP Cerber > Anti-Spam > [recaptcha]
https://www.google.com/recaptcha/