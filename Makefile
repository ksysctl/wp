#!make

# base paths
dev_dir=dev
data_dir=data

# general paths
deploy_dir=$(dev_dir)/deploy
build_dir=$(dev_dir)/build
script_dir=$(dev_dir)/script

# config file
env_file=$(deploy_dir)/.env

# include/export .env from file
ifneq ("$(wildcard $(env_file))","")
	include $(env_file)
	export $(shell sed 's/=.*//' $(env_file))
endif

# general files
compose_file=$(build_dir)/docker-compose.yml
docker_file=$(build_dir)/Dockerfile
setup_file=$(script_dir)/setup.sh
live_dump=$(data_dir)/sql/live.sql
local_dump=$(data_dir)/sql/local.sql
clean_sql=$(data_dir)/sql/tools/clean.sql
optimize_sql=$(data_dir)/sql/tools/optimize.sql

# regex string substitution
regex_str=([a-zA-Z0-9+]?.*)
regex_strx=([_a-zA-Z0-9+]?.*)

# common args. passed to docker compose
common_args=-f $(compose_file) --env-file $(env_file)

# valid targets
.PHONY: build rebuild up down \
	logs shell \
	restore backup \
	setup \
	change-server change-manager change-option \
	change-akismet change-recaptcha \
	clean-system update-plugins

# args. for our Makefile from CLI
domain ?= $(WP_LOCAL_SERVER)
username ?= ''
email ?= ''
password ?= ''
blogname ?= $(WP_PROJECT)
blogdesc ?= ''
akismet_key ?= $(WP_AKISMET_KEY)
recaptcha_key ?= $(WP_RECAPTCHA_KEY)
recaptcha_secret ?= $(WP_RECAPTCHA_SECRET)

# targets
all: build
build:
ifdef WP_PROJECT
	@docker-compose $(common_args) up --build --remove-orphans
endif
rebuild:
ifdef WP_PROJECT
	@docker-compose $(common_args) build --no-cache
endif
up:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
endif
down:
ifdef WP_PROJECT
	@docker-compose $(common_args) down
endif
logs:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@docker-compose $(common_args) --verbose logs -f
endif
shell:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@docker exec -it wp_webserver bash
endif
restore:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@cat $(live_dump) | docker exec -i db_mysql \
		mysql -uroot -p$(DB_ROOT_PASSWORD) $(DB_NAME) >/dev/null
	
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root search-replace $(WP_LIVE_SERVER) $(WP_LOCAL_SERVER) --skip-columns=guid'
endif
backup:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@docker-compose $(common_args) exec db sh -c \
		'exec mysqldump $(DB_NAME) -uroot -p$(DB_ROOT_PASSWORD)' > $(local_dump)

	@sed -i '.bak' 1,1d $(local_dump) && rm "$(local_dump).bak"
endif
setup:
ifndef WP_PROJECT
	./$(setup_file)
endif
change-server:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root maintenance-mode activate'
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root search-replace $(WP_LOCAL_SERVER) $(domain) --skip-columns=guid'
	@docker-compose $(common_args) exec wp sh -c \
		'rm -Rf /var/www/html/wp-content/cache/*'
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root maintenance-mode deactivate'
	@docker-compose $(common_args) down

	sed -i "" 's/$(WP_LOCAL_SERVER)/$(domain)/g' dev/deploy/.env
	sed -i "" 's/$(WP_LOCAL_SERVER)/$(domain)/g' dev/deploy/apache/default.conf
	sed -i "" 's/$(WP_LOCAL_SERVER)/$(domain)/g' wordpress/.htaccess
	sudo sh -c "sed -i \"\" 's/127.0.0.1	$(WP_LOCAL_SERVER)/127.0.0.1	$(domain)/g' /etc/hosts"

	@docker-compose $(common_args) up --build --remove-orphans
endif
change-manager:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root user create $(username) $(email) --user_pass=$(password) --role=administrator --porcelain'
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root user session destroy cms --all'
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root user delete cms --yes'
endif
change-option:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root option update blogname "$(blogname)"'
	@sed -i "" -E 's/WP_PROJECT=$(regex_strx)/WP_PROJECT=$(blogname)/g' dev/deploy/.env
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root option update blogdescription "$(blogdesc)"'
endif
clean-system:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root maintenance-mode activate'
	@docker-compose $(common_args) exec wp sh -c \
		'rm -Rf /var/www/html/wp-content/cache/*'
	@cat $(clean_sql) | docker exec -i db_mysql \
		mysql -uroot -p$(DB_ROOT_PASSWORD) $(DB_NAME) >/dev/null
	@cat $(optimize_sql) | docker exec -i db_mysql \
		mysql -uroot -p$(DB_ROOT_PASSWORD) $(DB_NAME) >/dev/null
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root maintenance-mode deactivate'
endif
update-plugins:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root plugin update --all'
endif
change-akismet:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root option update wordpress_api_key "$(akismet_key)"'
	@sed -i "" -E 's/WP_AKISMET_KEY=$(regex_str)/WP_AKISMET_KEY=$(akismet_key)/g' dev/deploy/.env
endif
change-recaptcha:
ifdef WP_PROJECT
	@docker-compose $(common_args) up -d
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root option patch update cerber-recaptcha sitekey "$(recaptcha_key)"'
	@sed -i "" -E 's/WP_RECAPTCHA_KEY=$(regex_str)/WP_RECAPTCHA_KEY=$(recaptcha_key)/g' dev/deploy/.env
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root option patch update cerber-recaptcha secretkey "$(recaptcha_secret)"'
	@sed -i "" -E 's/WP_RECAPTCHA_SECRET=$(regex_str)/WP_RECAPTCHA_SECRET=$(recaptcha_secret)/g' dev/deploy/.env
endif