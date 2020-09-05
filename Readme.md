## To start docker
```docker-compose up -d```

## Log in to flutter container
```docker exec -it flutter bash```

### If the above command fails
```docker container ps```
### Copy the container id from the above command and run
```docker exec -it {CONTAINER_ID} bash```

## To create flutter project
```flutter create .```

## To build android apk
```flutter build apk```

### To build android apk without getting into docker
```docker exec -it flutter bash -c 'flutter build apk'```

## To run android in emulator on host system, start your emulator
```
adb devices
adb connect host.docker.internal:5555
flutter run
```