Test 

- build image
```
docker build -t timtest:1.0 .
```
- -t for tag of image, ease of ref later include version number

- run image
- Linux syntax
```
docker run -d -p 9090:80 -v $(pwd):/var/www/logs -t --name webserver timtest:1.0
```
- Powershell syntax
```
docker run -d -p 9090:80 -v ${PWD}:/var/www/logs --name webserver timtest:1.0
```

- -d for detatched mode, keep console available
- -p for port define host:container set in default
- -v for volume mount a directory on container to host
- -it TTY, terminal to container on run
- --name for defining container name
