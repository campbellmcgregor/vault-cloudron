#!/bin/bash
set -eu

export VAULT_ADDR="http://0.0.0.0:8200"
export VAULT_API_ADDR="http://0.0.0.0:8200"

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

exec vault write auth/ldap/config \
     url="ldap://${CLOUDRON_LDAP_SERVER}" \
     userdn="${CLOUDRON_LDAP_USERS_BASE_DN}" \
     groupdn="${CLOUDRON_LDAP_GROUPS_BASE_DN}" \
     binddn="${CLOUDRON_LDAP_BIND_DN}" \
     bindpass="${CLOUDRON_LDAP_BIND_PASSWORD}"