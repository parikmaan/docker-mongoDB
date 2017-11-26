FROM debian:8.9

MAINTAINER <Parik Maan>

# User root user
USER root

# Install MongoDB
RUN apt-get update && \
    groupadd -r mongodb && \
    useradd -r -g mongodb mongodb && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && \
    echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    apt-get update && \
    apt-get install -y mongodb-org && \
    mkdir -p /data/db && \
    chown -R mongodb:mongodb /data/db && \
    chown -R mongodb:mongodb /usr/bin/mongo*
EXPOSE 27017
COPY conf/mongodb.conf /data/db/mongodb/conf/mongodb.conf

# Use mongodb user
USER mongodb

# Start MongoDB
ENTRYPOINT ["/usr/bin/mongod", "--config", "/data/db/mongodb/conf/mongodb.conf"]
