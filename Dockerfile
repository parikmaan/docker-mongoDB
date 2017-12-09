FROM debian:jessie-slim
MAINTAINER <Parik Maan>

# Create mongo working directory
RUN mkdir -p /mongodb
WORKDIR /mongodb

# Copy config files
COPY conf conf

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 && \
    echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list && \
    apt-get update && \
    apt-get install -y mongodb-org=3.6.0 mongodb-org-server=3.6.0 mongodb-org-shell=3.6.0 mongodb-org-mongos=3.6.0 mongodb-org-tools=3.6.0 && \
    chown -R mongodb:mongodb /usr/bin/mongo*

# Expose MongoDB port
EXPOSE 27017

CMD ["/usr/local/mongodb/bin/mongod", "--config" "/etc/mongodb.conf"]
