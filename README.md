# docker-mongoDB
MongoDB using docker.

# Installation
1. Clone the repository
2. Build:

    sh build.sh
3. Startup:

    sh start.sh
4. Create mongodb user:
    
    docker exec -it docker-mongodb mongo admin
    
    db.createUser({ user: 'admin', pwd: 'password', roles: [ { role: "dbOwner", db: "admin" } ] });
