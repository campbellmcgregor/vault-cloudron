#!/bin/bash
set -eu

set -x

if [ ! -e "config.hcl" ]; then
	cat <<-EOF > "$CONFIG_PATH/config.hcl"
disable_mlock = false

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

mkdir -p /app/data/vault-store
chown -R cloudron:cloudron /run /app/data

# This block of code can be used to have the startup script init the vault for you
# at current when the vault starts you can generate the keys and download them safely
# using the UI simply head to the installed URL and init the vault.

# # Init the vault if not yet done. Keys printed to stdout need to be copied and stored safely
# if [ ! -e "init-completed" ]; then
#   ( sleep 20;
#   /app/code/vault operator init -address=http://127.0.0.1:8200;
#   touch init-completed)&
# fi

exec gosu cloudron:cloudron /app/code/vault server -config=/app/data/config.hcl
