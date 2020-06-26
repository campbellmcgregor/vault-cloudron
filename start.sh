#!/bin/bash
set -eu

if [ ! -e "config.hcl" ]; then
	cat <<-EOF > "$CONFIG_PATH/config.hcl"
disable_mlock = true

ui = true
storage "file" {
  path = "/app/data"
}

listener "tcp" {
 address     = "127.0.0.1:8200"
 tls_disable = 1
}
EOF
fi

chown -R cloudron:cloudron /run /app/data

exec /usr/bin/supervisord --configuration /etc/supervisor/supervisord.conf --nodaemon -i vault

./vault server -config=/app/data/config.hcl