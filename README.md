Example project to demonstrate https://github.com/balena-io/balena-cli/issues/1032

Building with Docker works
```
$ make docker
docker build -t balena-gitignore .
Sending build context to Docker daemon  2.081MB
Step 1/7 : FROM golang:1.11.2-alpine
 ---> 57915f96905a
Step 2/7 : WORKDIR /go/src/github.com/magiconair/balena-github
 ---> Using cache
 ---> 3f00805764b3
Step 3/7 : COPY . .
 ---> dae3aa930d08
Step 4/7 : RUN ls -la vendor/
 ---> Running in 224dccfb17d0
total 12
drwxr-xr-x    3 root     root          4096 Nov 26 21:40 .
drwxr-xr-x    1 root     root          4096 Nov 26 21:57 ..
drwxr-xr-x    2 root     root          4096 Nov 26 21:42 lib
Removing intermediate container 224dccfb17d0
 ---> c34ac0342334
Step 5/7 : RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build
 ---> Running in b4f759e18306
Removing intermediate container b4f759e18306
 ---> 26487185cac8
Step 6/7 : RUN cp balena-github /bin
 ---> Running in d0393239ac86
Removing intermediate container d0393239ac86
 ---> 835522890348
Step 7/7 : CMD ["balena-github"]
 ---> Running in dcd54046939e
Removing intermediate container dcd54046939e
 ---> 238986fdd6d8
Successfully built 238986fdd6d8
Successfully tagged balena-gitignore:latest
docker run --rm -i -t balena-gitignore
lib.X: 5
```

Building with  `balena build` fails because of `vendor/lib/.gitignore`
which excludes the `vendor` folder (just like https://github.com/census-instrumentation/opencensus-go/blob/master/.gitignore for example)

```
$ balena version
9.3.2

$ make balena
balena build --deviceType fincm3 --arch armv7hf --logs
[Info]    Creating default composition with source: /Users/frank/src/github.com/magiconair/balena-gitignore
[Info]    Building for armv7hf/fincm3
[Build]   Building services...
[Build]   main Preparing...
[Build]   main Step 1/7 : FROM golang:1.11.2-alpine
[Build]   main  ---> 57915f96905a
[Build]   main Step 2/7 : WORKDIR /go/src/github.com/magiconair/balena-github
[Build]   main  ---> Using cache
[Build]   main  ---> 3f00805764b3
[Build]   main Step 3/7 : COPY . .
[Build]   main  ---> Using cache
[Build]   main  ---> 29aa753a86db
[Build]   main Step 4/7 : RUN ls -la vendor/
[Build]   main  ---> Running in 68a8d187390e
[Build]   main ls: vendor/: No such file or directory
[Build]   Built 1 service in 0:01
[Error]   Build failed
The command '/bin/sh -c ls -la vendor/' returned a non-zero code: 1

If you need help, don't hesitate in contacting us at:

  GitHub: https://github.com/balena-io/balena-cli/issues/new
  Forums: https://forums.balena.io

gmake: *** [Makefile:6: balena] Error 1	
```
