FROM debian:8.9
MAINTAINER <Parik Maan>

# Install MongoDB
RUN apt-get update && \
    groupadd -r mongodb && \
    useradd -r -g mongodb mongodb && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && \
    echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    apt-get update && \
    apt-get install -y mongodb-org && \
    chown -R mongodb:mongodb /usr/bin/mongo*

# Expose MongoDB port
EXPOSE 27017

# Setup work directory
ENV INSTALL_PATH /mongodb
RUN mkdir -p ${INSTALL_PATH}
WORKDIR ${INSTALL_PATH}

COPY conf/mongodb.conf conf/mongodb.conf

# Start MongoDB
CMD /usr/bin/mongod --config /mongodb/conf/mongodb.conf
