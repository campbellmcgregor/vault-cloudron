FROM cloudron/base:2.0.0@sha256:f9fea80513aa7c92fe2e7bf3978b54c8ac5222f47a9a32a7f8833edf0eb5a4f4

RUN apt-get update && \
    apt-get install -y libcap2-bin && \
    rm -rf /var/cache/apt /var/lib/apt/lists


# this is the default port for the webui and the REST gui
EXPOSE 8200 8201

# setting config path
ENV \
    VAULT_ADDR="http://127.0.0.1:8200" \
    VAULT_API_ADDR="http://127.0.0.1:8200" \
    CONFIG_PATH="/app/data/" \
    VAULT="/app/code/vault" \
    HOME="/app/data/"

# throwing ourselves into said cool directory
WORKDIR /app/code

# use wget to the latest binary compile for Linux
ENV VAULT_VERSION=1.4.2
RUN mkdir -p /app/pkg /app/code && \
    chown -R cloudron:cloudron /app/code /app/pkg 
RUN wget https://releases.hashicorp.com/vault/1.4.2/vault_${VAULT_VERSION}_linux_amd64.zip  && \
    unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /app/code && \
    rm -f /app/code/vault_${VAULT_VERSION}_linux_amd64.zip

# set file caps so the executable can run mlock as non privileged user (https://github.com/hashicorp/vault/issues/122)
RUN setcap cap_ipc_lock=+ep /app/code/vault

# copy start script and LDAP config
# TODO start.sh and any other script should be copied in a single layer
COPY start.sh ldap-config.sh /app/pkg/
#COPY configure_ldap.sh /app/data

# set the container to connect into the data folder as a nice user friendly thing
WORKDIR /app/data

# kicking off the start script
CMD [ "/app/pkg/start.sh" ]

