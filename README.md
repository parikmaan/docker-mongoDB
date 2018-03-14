# MongoDB using docker.

# Installation

1. Clone the repository

2. Build:

    docker image build -t TAG .

3. Startup:

    sh scripts/start.sh

4. Create mongodb user:
    
    docker exec -it docker-mongodb mongo admin
    
    db.createUser({ user: 'admin', pwd: 'password', roles: [ { role: "dbOwner", db: "admin" } ] });
