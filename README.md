# WP Docker Project
A Wordpress Docker Project.

# Getting started
## Requirements
- [Docker](https://docs.docker.com/engine/installation/)
- [Docker compose](https://docs.docker.com/compose/install/)
- [Git](https://git-scm.com/downloads)

Installed plugins:
- [ ] Advanced Custom Fields [5.8.9](https://www.advancedcustomfields.com/).
- [ ] Advanced DB Cleaner [3.0.0](https://sigmaplugin.com/downloads/wordpress-advanced-database-cleaner).
- [ ] Akismet Anti-Spam [4.1.5](https://akismet.com/).
- [ ] Polylang [2.7.2](https://polylang.pro).
- [ ] Query Monitor [3.5.2](https://github.com/johnbillion/query-monitor)
- [ ] WP Cerber Security [8.6.3](https://wpcerber.com).
- [ ] WP Fastest Cache [0.9.0.5](http://wordpress.org/plugins/wp-fastest-cache/).
- [ ] WP Mail SMTP [2.0.0](https://wpmailsmtp.com/).

## Setup
  * WP Panel: username/password```cms/cms```, accessed from [cms.loc/mngr](https://cms.loc/mngr)
  * Mailcatcher UI: acceded from [cms.loc:1080](http://cms.loc:1080)

### Create Project Env
1. Create Run setup to initialize project, it will create a ```.env``` file in ```dev/deploy```, it does not overwrite ```.env``` if already exists. Setup creates structure to handle DB files, modifies ```/etc/hosts``` to resolve your local server name.
```bash
git clone git@github.com:ksysctl/wp.git myproject
cd myproject
make setup
```
### Customize Project Env
2. Before starting to build the project, modify the recently generated ```.env```:

#### Secrets
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

#### PHP
Modify PHP settings if needed:
```
dev/deploy/php.ini
```

Modify XDEBUG settings if you need to enable/disable it:
```
dev/deploy/xdebug.ini
```

Change localhost with your host IP, use ifconfig|ipconfig to get it.
```ini
xdebug.remote_host=localhost
```

If you need to enable it, set XDEBUG_ENABLED as 1 in your ```.env``` file.
```env
XDEBUG_ENABLED=0
```

## Build
3. Build the image and import customized database.
```bash
make build
make restore
```

- [ ] *Remember [change](#plugins) akismet/recaptcha keys, defaults provided are for local environment use.*

# Docker 
Use Makefile to manage your images and containers.

### Build
Run *build/rebuild* to initialize WP/DB, ensure that ```.env``` exists:
```bash
make build
```
o
```bash
make rebuild
```

### Logs
Run *logs* to show container logs, if ```WORDPRESS_DEV_MODE``` is set as ```DEV```, wordpress logs can be found at ```wp-content/debug.log```:
```bash
make logs
```

### Shell
Run *shell* to access to the container:
```bash
make shell
```

### Up/Down
Run *up/down* to start/stop container:
```bash
make up
```
o
```bash
make down
```

# Database

## Restore
Restores DB from live and fixes urls, it loads a ```live.sql``` dump file stored in ```data/sql```:

```bash
make restore
```

## Backup
Creates a backup, exports a ```local.sql``` dump file in ```data/sql```:
```bash
make restore
```

# Develop tools

## XDebug
Config file launch.json for *VS Code*.
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
Create a new user with admin privileges, it replaces default `cms` that will be deleted.
```bash
make change-manager username='<username>' email='<email>' password='<password>'
```

### Clean system
Clean temporal files, cache, database tables, it removes pending, trashed, auto-draft, orphaned posts/comments, etc.
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
Modify local server name running, ensure to set up your *recaptcha* and *akismet* key/secret for the new domain in ```.env```.
```bash
make change-server domain='<new dns>'
```

#### Apache
- Modify if needed ```dev/deploy/apache/default.conf``` for unsecure connections.
- Modify if needed ```dev/deploy/apache/default.ssl.conf``` for secure connections.
- Modify if needed ```dev/deploy/apache/security.conf``` for security settings.
- Modify if needed ```dev/deploy/apache/http.conf``` for global settings.
```bash
make build
```

### Plugins
Generate keys/secrets from [akismet.com](https://akismet.com/signup/) | [recaptcha](https://www.google.com/recaptcha/):

```env
WP_AKISMET_KEY=
WP_RECAPTCHA_KEY=
WP_RECAPTCHA_SECRET=
```

#### Akismet
Changes akismet key.
```bash
make change-akismet akismet_key='<key>'
```
if new value is stored in .env then skip akismet_key parameter.
```bash
make change-akismet
```

#### Recaptcha
Change cerber recaptcha key/secret.
```bash
make change-recaptcha recaptcha_key='<key>' recaptcha_secret='<secret>'
```
if new values are stored in .env then skip recaptcha key|recaptcha secret parameter.
```bash
make change-akismet
```
