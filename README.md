Test 

- build image
```
docker build -t timtest:1.0 .
```
- -t for tag of image, ease of ref later include version number

- run image
```
docker run -d -p 9090:80 --name webserver timtest:1.0
```

- -d for detatched mode, keep console available
- -p for port define host:container set in default
- --name for defining container name
