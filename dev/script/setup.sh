#!/bin/sh

dev_dir=dev
database_dir=data
deploy_dir=${dev_dir}/deploy
hosts_file="/etc/hosts"
server="cms.loc"

echo "Creating config file in ${deploy_dir} for WP > "
cp  ${deploy_dir}/.env.template ${deploy_dir}/.env

echo "Creating directories in ${database_dir}/* for DB > "
mkdir -p ${database_dir}/sql ${database_dir}/db ${database_dir}/backup

echo "Updating local /etc/hosts..."
if ! grep -q ${server} ${hosts_file} ; then
	sudo sh -c "echo '127.0.0.1	${server}' >> ${hosts_file}"
fi