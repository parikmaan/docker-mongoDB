#!/bin/bash

ADMIN_USER=${ADMIN_USER:-"admin"}
ADMIN_PASS=${ADMIN_PASS:-"password"}

APPLICATION_DATABASE=${APPLICATION_DATABASE:-"appdb"}
APPLICATION_USER=${APPLICATION_USER:-"user"}
APPLICATION_PASS=${APPLICATION_PASS:-"password"}

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
echo "Create admin user."
echo "-----------------------------------"
mongo admin --eval "db.createUser({user: '$ADMIN_USER', pwd: '$ADMIN_PASS', roles:[{role:'root',db:'admin'}]});"

sleep 5

# Application user
echo "-----------------------------------"
echo "Create application user."
echo "-----------------------------------"
mongo admin -u $ADMIN_USER -p $ADMIN_PASS << EOF
use $APPLICATION_DATABASE
db.createUser({user: '$APPLICATION_USER', pwd: '$APPLICATION_PASS', roles:[{role:'dbOwner', db:'$APPLICATION_DATABASE'}]})
EOF

sleep 5

touch /mongodb/auth_initialized

echo "-----------------------------------"
echo "MongoDB authentication setup completed."
echo "-----------------------------------"
