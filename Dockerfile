FROM cloudron/base:2.0.0@sha256:f9fea80513aa7c92fe2e7bf3978b54c8ac5222f47a9a32a7f8833edf0eb5a4f4

# this is the default port for the webui and the REST gui
EXPOSE 8200 8201

# setting config path
ENV CONFIG_PATH="/app/data/"

# creating some cool directories
RUN mkdir -p /app/code /app/pkg

# throwing ourselves into said cool directory
RUN cd /app/code

# use wget to the latest binary compile for Linux
RUN wget https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip 

# unzipping the bin to app/code
RUN unzip vault_1.4.2_linux_amd64.zip -d /app/code

# copy start script into the code dir
COPY start.sh /app/pkg

# organise some permissions
RUN chown -R cloudron:cloudron /app/code

# sorting out the supervisor configs and their log files
RUN sed -e 's,^logfile=.*$,logfile=/run/supervisord.log,' -i /etc/supervisor/supervisord.conf
COPY supervisor-vault.conf /etc/supervisor/conf.d/

# set the container to connect into the data folder as a nice user friendly thing
WORKDIR /app/data

# kicking off the start script
CMD [ "/app/pkg/start.sh" ]

