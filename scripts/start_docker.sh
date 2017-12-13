docker container run -d -p 27017:27017 --name docker-mongodb --mount type=bind, source=/mongodb,target=/mongodb parikmaan/docker-mongodb
