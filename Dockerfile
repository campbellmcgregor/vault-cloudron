FROM cloudron/base:2.0.0@sha256:f9fea80513aa7c92fe2e7bf3978b54c8ac5222f47a9a32a7f8833edf0eb5a4f4

EXPOSE 3000


RUN mkdir -p /app/code && cd /app/code

#RUN sudo apt-get update && sudo apt-get -y install golang 

#ENV GOPATH="/usr/local/go-1.14.2/bin/go"

#RUN GOPATH="/usr/local/go-1.14.2/bin/go"

RUN wget https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip

RUN unzip -xz vault_1.4.2_linux_amd64.zip

