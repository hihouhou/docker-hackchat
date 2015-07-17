#
# Hack chat server Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

# Update & install packages
RUN apt-get update && \
    apt-get install -y git python make g++ curl

RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash - && \
apt-get install --yes nodejs

# install hackchat server
RUN git clone https://github.com/AndrewBelt/hack.chat.git && \
cd hack.chat && \
npm install && \
cp config-sample.json config.json

#install pm2
RUN cd /hack.chat && \
npm install pm2 -g


# install hackchat client
RUN cd /hack.chat/client && \
npm install -g less jade http-server && \
make
ADD client.js /hack.chat/client/

EXPOSE 6060
CMD pm2 start /hack.chat/server.js && cd /hack.chat/client && http-server
