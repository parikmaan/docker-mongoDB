#!/bin/bash
set -m

mongodb_cmd="mongod --config /mongodb/conf/mongodb.conf"
cmd="$mongodb_cmd"

$cmd &

if [ ! -f /mongodb/auth_initialized ]; then
    /set_mongodb_password.sh
fi

fg
