#!/bin/bash
set -eu

export VAULT_ADDR="0.0.0.0:8200"
#export VAULT_API_ADDR=

if [ ! -e "config.hcl" ]; then
	cat <<-EOF > "$CONFIG_PATH/config.hcl"
disable_mlock = true

ui = true
storage "file" {
  path = "/app/data/vault-store/"
}

listener "tcp" {
 address     = "0.0.0.0:8200"
 tls_disable = 1
}
EOF
fi

chown -R cloudron:cloudron /run /app/data

exec /usr/bin/supervisord --configuration /etc/supervisor/supervisord.conf --nodaemon -i vault

exec /app/code/vault operator init -address=http://127.0.0.1:8200 >> /app/data/vault_init.txt