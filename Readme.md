## To start docker
```docker-compose up -d```

## Log in to flutter container
```docker exec -it flutter bash```

### If the above command fails run
```docker container ps```
### Copy the container id from the above command and run
```docker exec -it {CONTAINER_ID} bash```

## To create flutter project
```flutter create .```

## To build android apk
```flutter build apk```