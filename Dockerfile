FROM debian:jessie-slim
MAINTAINER <Parik Maan>

# Install MongoDB
RUN set -x && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 && \
    echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list && \
    apt-get update
RUN set -x && \
    apt-get install -y --no-install-recommends apt-utils
RUN set -x && \
    apt-get install -y --no-install-recommends mongodb-org=3.6.0

# Create mongo working directory
RUN mkdir -p /mongodb/db /mongodb/logs
WORKDIR /mongodb
VOLUME docker-mongodb:/mongodb

# Copy files
COPY conf conf
COPY scripts scripts

RUN chmod +x scripts/entrypoint.sh
RUN chmod +x scripts/set_mongodb_password.sh

# Expose MongoDB port
EXPOSE 27017

CMD ["scripts/entrypoint.sh"]
