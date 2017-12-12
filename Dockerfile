FROM debian:jessie-slim
MAINTAINER <Parik Maan>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
#RUN groupadd -r mongodb && useradd -r -g mongodb mongodb


# Create mongo working directory
RUN mkdir -p /mongodb/data/logs && \
    mkdir -p /mongodb/data/db    
WORKDIR /mongodb

# Install MongoDB
RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends apt-utils
RUN set -x && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 && \
    echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list && \
    apt-get update && \
    apt-get install -y mongodb-org=3.6.0
#RUN set -x && \
#    chown -R mongodb:mongodb /usr/bin/mongo* && \
#    chown -R mongodb:mongodb /mongodb


# Copy files
COPY conf conf
COPY scripts scripts

# Expose MongoDB port
EXPOSE 27017

#ENTRYPOINT ["scripts/entrypoint.sh"]

CMD ["mongod", "--config /mongodb/conf/mongodb.conf"]
