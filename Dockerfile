FROM cloudron/base:2.0.0@sha256:f9fea80513aa7c92fe2e7bf3978b54c8ac5222f47a9a32a7f8833edf0eb5a4f4

# this is the default port for the webui and the REST gui
EXPOSE 8200 8201

ENV VAULT_VERSION=1.4.2
ENV VAULT_ADDR="http://127.0.0.1:8200"
ENV VAULT_API_ADDR="http://127.0.0.1:8200"

# setting config path
ENV CONFIG_PATH="/app/data/"
ENV VAULT="/app/code/vault"

# creating some cool directories
RUN mkdir -p /app/code /app/pkg /app/data/vault-store

# throwing ourselves into said cool directory
RUN cd /app/code

# use wget to the latest binary compile for Linux
RUN wget https://releases.hashicorp.com/vault/1.4.2/vault_${VAULT_VERSION}_linux_amd64.zip 

# unzipping the bin to app/code
RUN unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /app/code
RUN rm -f /vault_${VAULT_VERSION}_linux_amd64.zip

# copy start script and LDAP config
COPY start.sh /app/pkg
COPY configure_ldap.sh /app/data

# organise some permissions and make some stuff executable
RUN chown -R cloudron:cloudron /app/code /app/pkg
RUN chmod +x /app/pkg/start.sh
RUN chmod +x /app/data/configure_ldap.sh

# sorting out the supervisor configs and their log files
RUN sed -e 's,^logfile=.*$,logfile=/run/supervisord.log,' -i /etc/supervisor/supervisord.conf
COPY supervisor-vault.conf /etc/supervisor/conf.d/

# set the container to connect into the data folder as a nice user friendly thing
WORKDIR /app/data

# kicking off the start script
CMD [ "/app/pkg/start.sh" ]

