#!/bin/bash

ADMIN_USER=${MONGODB_ADMIN_USER:-"admin"}
ADMIN_PASS=${MONGODB_ADMIN_PASS:-"password"}

APPLICATION_DATABASE=${MONGODB_APPLICATION_DATABASE:-"appdb"}
APPLICATION_USER=${MONGODB_APPLICATION_USER:-"user"}
APPLICATION_PASS=${MONGODB_APPLICATION_PASS:-"password"}

RET=1
while [[ RET -ne 0 ]]; do
    echo "-----------------------------------"
    echo "Waiting for MongoDB service startup"
    echo "-----------------------------------"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

# Admin user
echo "-----------------------------------"
echo "Create admin user. $MONGODB_ADMIN_USER:$MONGODB_ADMIN_PASS"
echo "-----------------------------------"
mongo admin --eval "db.createUser({user: '$MONGODB_ADMIN_USER', pwd: '$MONGODB_ADMIN_PASS', roles:[{role:'root',db:'admin'}]});"

sleep 5

# Application user
echo "-----------------------------------"
echo "Create application user."
echo "-----------------------------------"
mongo admin -u $MONGODB_ADMIN_USER -p $MONGODB_ADMIN_PASS << EOF
use $MONGODB_APPLICATION_DATABASE
db.createUser({user: '$MONGODB_APPLICATION_USER', pwd: '$MONGODB_APPLICATION_PASS', roles:[{role:'dbOwner', db:'$MONGODB_APPLICATION_DATABASE'}]})
EOF

sleep 5

touch /mongodb/auth_initialized

echo "-----------------------------------"
echo "MongoDB authentication setup completed."
echo "-----------------------------------"
