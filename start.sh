docker run --name docker-mongodb -it \
-v /data/db:/data/db \
-e MONGODB_ADMIN_USER=admin \
-e MONGODB_ADMIN_PASS=adminpass \
-e MONGODB_APPLICATION_DATABASE=mytestdatabase \
-e MONGODB_APPLICATION_USER=testuser \
-e MONGODB_APPLICATION_PASS=testpass \
-p 27017:27017 parikmaan/docker-mongodb:latest
