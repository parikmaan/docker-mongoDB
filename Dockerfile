FROM debian:8.9

MAINTAINER <Parik Maan>

# Get APT updates
RUN apt-get update

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update
RUN apt-get install -y mongodb-org
#RUN mkdir -p /data/db
EXPOSE 27017
COPY conf/mongodb.conf /data/db/mongodb/conf/mongodb.conf

# Start MongoDB
#ENTRYPOINT ["usr/bin/mongod", "--config", "/data/db/mongodb/conf/mongodb.conf"]
