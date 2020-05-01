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
regex_email=([_@a-zA-Z0-9+]?.*)

# common args. passed to docker compose
common_args=-f $(compose_file) --env-file $(env_file)

# valid targets
.PHONY: build rebuild up down \
	logs shell \
	restore backup \
	setup \
	change-server change-manager change-option \
	change-akismet change-recaptcha \
	clean-system update-plugins \
	mail-set mail-smtp

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
mail_from ?= $(MAIL_FROM)
mail_name ?= $(MAIL_NAME)
mail_mailer ?= $(MAIL_MAILER)
smtp_host ?= $(SMTP_HOST)
smtp_port ?= $(SMTP_PORT)
smtp_autotls ?= $(SMTP_AUTO_TLS)
smtp_auth ?= $(SMTP_AUTH)
smtp_encryption ?= $(SMTP_ENCRYPTION)
smtp_user ?= $(SMTP_USER)
smtp_pass ?= $(SMTP_PASS)

# function: wait db service is up
define wait_db_service
	@docker-compose $(common_args) up -d
	@while [ ! "$$(docker ps -q -f name=$(DB_CONTAINER))" ] ; do sleep 1; done;
	@while [ ! \
		"$$(docker exec -i $(DB_CONTAINER) \
			mysqladmin --user=root --password=$(DB_ROOT_PASSWORD) --host 127.0.0.1 ping --silent)" \
		] ; do \
		sleep 1; \
	done;
endef

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
	$(call wait_db_service)
	@docker-compose $(common_args) --verbose logs -f
endif
shell:
ifdef WP_PROJECT
	$(call wait_db_service)
	@docker exec -it $(WP_CONTAINER) bash
endif
restore:
ifdef WP_PROJECT
	$(call wait_db_service)
	@cat $(live_dump) | docker exec -i $(DB_CONTAINER) \
		mysql -uroot -p$(DB_ROOT_PASSWORD) $(DB_NAME) >/dev/null
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root search-replace $(WP_LIVE_SERVER) $(WP_LOCAL_SERVER) --skip-columns=guid'
endif
backup:
ifdef WP_PROJECT
	$(call wait_db_service)
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
	$(call wait_db_service)
	@docker-compose $(common_args) exec wp sh -c '\
		wp --allow-root maintenance-mode activate; \
		wp --allow-root search-replace $(WP_LOCAL_SERVER) $(domain) --skip-columns=guid; \
		rm -Rf /var/www/html/wp-content/cache/*; \
		wp --allow-root maintenance-mode deactivate;'	
	@docker-compose $(common_args) down
	sed -i "" 's/$(WP_LOCAL_SERVER)/$(domain)/g' dev/deploy/.env
	sed -i "" 's/$(WP_LOCAL_SERVER)/$(domain)/g' dev/deploy/apache/default.conf
	sed -i "" 's/$(WP_LOCAL_SERVER)/$(domain)/g' wordpress/.htaccess
	sudo sh -c "sed -i \"\" 's/127.0.0.1	$(WP_LOCAL_SERVER)/127.0.0.1	$(domain)/g' /etc/hosts"
	@docker-compose $(common_args) up --build --remove-orphans
endif
change-manager:
ifdef WP_PROJECT
	$(call wait_db_service)
	@docker-compose $(common_args) exec wp sh -c '\
		wp --allow-root user create $(username) $(email) --user_pass=$(password) --role=administrator --porcelain; \
		wp --allow-root user session destroy cms --all; \
		wp --allow-root user delete cms --yes;'
endif
change-option:
ifdef WP_PROJECT
	$(call wait_db_service)
	@docker-compose $(common_args) exec wp sh -c '\
		wp --allow-root option update blogname "$(blogname)"; \
		wp --allow-root option update blogdescription "$(blogdesc)";'
	@sed -i "" -E 's/WP_PROJECT=$(regex_strx)/WP_PROJECT=$(blogname)/g' dev/deploy/.env
endif
clean-system:
ifdef WP_PROJECT
	$(call wait_db_service)
	@docker-compose $(common_args) exec wp sh -c '\
		wp --allow-root maintenance-mode activate; \
		rm -Rf /var/www/html/wp-content/cache/*;'
	@cat $(clean_sql) | docker exec -i $(DB_CONTAINER) \
		mysql -uroot -p$(DB_ROOT_PASSWORD) $(DB_NAME) >/dev/null
	@cat $(optimize_sql) | docker exec -i $(DB_CONTAINER) \
		mysql -uroot -p$(DB_ROOT_PASSWORD) $(DB_NAME) >/dev/null
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root maintenance-mode deactivate;'
endif
update-plugins:
ifdef WP_PROJECT
	$(call wait_db_service)
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root plugin update --all;'
endif
change-akismet:
ifdef WP_PROJECT
	$(call wait_db_service)
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root option update wordpress_api_key "$(akismet_key)";'
	@sed -i "" -E 's/WP_AKISMET_KEY=$(regex_str)/WP_AKISMET_KEY=$(akismet_key)/g' dev/deploy/.env
endif
change-recaptcha:
ifdef WP_PROJECT
	$(call wait_db_service)
	@docker-compose $(common_args) exec wp sh -c '\
		wp --allow-root option patch update cerber-recaptcha sitekey "$(recaptcha_key)"; \
		wp --allow-root option patch update cerber-recaptcha secretkey "$(recaptcha_secret)";'
	@sed -i "" -E 's/WP_RECAPTCHA_KEY=$(regex_str)/WP_RECAPTCHA_KEY=$(recaptcha_key)/g' dev/deploy/.env
	@sed -i "" -E 's/WP_RECAPTCHA_SECRET=$(regex_str)/WP_RECAPTCHA_SECRET=$(recaptcha_secret)/g' dev/deploy/.env
endif
mail-set:
ifdef WP_PROJECT
	$(call wait_db_service)
	@docker-compose $(common_args) exec wp sh -c '\
		wp --allow-root option patch update wp_mail_smtp mail from_email "$(mail_from)"; \
		wp --allow-root option patch update wp_mail_smtp mail from_name "$(mail_name)"; \
		wp --allow-root option patch update wp_mail_smtp mail mailer "$(mail_mailer)";'
	@sed -i "" -E 's/MAIL_FROM=$(regex_email)/MAIL_FROM=$(mail_from)/g' dev/deploy/.env
	@sed -i "" -E 's/MAIL_NAME=$(regex_strx)/MAIL_NAME=$(mail_name)/g' dev/deploy/.env
	@sed -i "" -E 's/MAIL_MAILER=$(regex_strx)/MAIL_MAILER=$(mail_mailer)/g' dev/deploy/.env
endif
mail-smtp:
ifdef WP_PROJECT
	$(call wait_db_service)
	@docker-compose $(common_args) exec wp sh -c '\
		wp --allow-root option patch update wp_mail_smtp smtp host "$(smtp_host)"; \
		wp --allow-root option patch update wp_mail_smtp smtp port "$(smtp_port)"; \
		wp --allow-root option patch update wp_mail_smtp smtp autotls $(smtp_autotls); \
		wp --allow-root option patch update wp_mail_smtp smtp auth $(smtp_auth); \
		wp --allow-root option patch update wp_mail_smtp smtp encryption $(smtp_encryption); \
		wp --allow-root option patch update wp_mail_smtp smtp user "$(smtp_user)"; \
		wp --allow-root option patch update wp_mail_smtp smtp pass "$(smtp_pass)";'
	@sed -i "" -E 's/SMTP_HOST=$(regex_strx)/SMTP_HOST=$(smtp_host)/g' dev/deploy/.env
	@sed -i "" -E 's/SMTP_PORT=$(regex_strx)/SMTP_PORT=$(smtp_port)/g' dev/deploy/.env
	@sed -i "" -E 's/SMTP_AUTO_TLS=$(regex_strx)/SMTP_AUTO_TLS=$(smtp_autotls)/g' dev/deploy/.env
	@sed -i "" -E 's/SMTP_AUTH=$(regex_strx)/SMTP_AUTH=$(smtp_auth)/g' dev/deploy/.env
	@sed -i "" -E 's/SMTP_ENCRYPTION=$(regex_strx)/SMTP_ENCRYPTION=$(smtp_encryption)/g' dev/deploy/.env
	@sed -i "" -E 's/SMTP_USER=$(regex_strx)/SMTP_USER=$(smtp_user)/g' dev/deploy/.env
	@sed -i "" -E 's/SMTP_PASS=$(regex_strx)/SMTP_PASS=$(smtp_pass)/g' dev/deploy/.env
endif