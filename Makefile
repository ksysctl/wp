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

# common args. passed to docker compose
common_args=-f $(compose_file) --env-file $(env_file)

# valid targets
.PHONY: build rebuild up down \
	logs shell \
	restore backup \
	setup change

# args. for our Makefile from CLI
dns ?= $(WP_LOCAL_SERVER)

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
	@docker-compose $(common_args) --verbose logs -f
endif
shell:
ifdef WP_PROJECT
	@docker exec -it wp_webserver bash
endif
restore:
ifdef WP_PROJECT
	@cat $(live_dump) | docker exec -i db_mysql \
		mysql -uroot -p$(DB_ROOT_PASSWORD) $(DB_NAME) >/dev/null
	
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root search-replace $(WP_LIVE_SERVER) $(WP_LOCAL_SERVER) --skip-columns=guid'
endif
backup:
ifdef WP_PROJECT
	@docker-compose $(common_args) exec db sh -c \
		'exec mysqldump $(DB_NAME) -uroot -p$(DB_ROOT_PASSWORD)' > $(local_dump)

	@sed -i '.bak' 1,1d $(local_dump) && rm "$(local_dump).bak"
endif
setup:
ifndef WP_PROJECT
	./$(setup_file)
endif
change:
ifdef WP_PROJECT
	@docker-compose $(common_args) exec wp sh -c \
		'wp --allow-root search-replace ${WP_LOCAL_SERVER} ${dns} --skip-columns=guid'
	@docker-compose $(common_args) exec wp sh -c \
		'rm -Rf /var/www/html/wp-content/cache/*'
	@docker-compose $(common_args) down

	sed -i "" 's/$(WP_LOCAL_SERVER)/$(dns)/g' dev/deploy/.env
	sed -i "" 's/$(WP_LOCAL_SERVER)/$(dns)/g' dev/deploy/apache/default.conf
	sed -i "" 's/$(WP_LOCAL_SERVER)/$(dns)/g' wordpress/.htaccess
	sudo sh -c "sed -i \"\" 's/127.0.0.1	$(WP_LOCAL_SERVER)/127.0.0.1	$(dns)/g' /etc/hosts"
	
	@docker-compose $(common_args) up --build --remove-orphans
endif