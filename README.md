# DevDock

## Description

My personal docker setup includes packages I often use, including the zsh shell.  The image was adopted from Sahil Malik's Docker for Developers[^1] article.

| package  | package |
| -------- | ------- |
| curl     | zsh     |
| git-core | jq      |
| gnu-pg   | wget    |
| locales  | nano    |
| sudo     |         |

## Usage

### Building

The Dockerfile takes 2 parameters

| Parameter | Default Value | Use                                  |
| --------- | ------------- | ------------------------------------ |
| user      | pi            | Create a user and home for the user. |
| password  | raspberry     | password for use                     |



```
# User default user password
docker build --rm -f Dockerfile -t devdock:snapshot-002 .

# Or specify a user
docker build --rm -f Dockerfile -t devdock:snapshot-002 \
--build-arg user=scott \
--build-arg password=tiger .
```

### Running 

#### Running ephemerally

Nothing gets saved. 

```
user=scott docker run -it devdock:snapshot-002 
# Specify shell to use (must exist on build), zsh is default
user=scott docker run -it devdock:snapshot-002 /bin/zsh
```

#### Running with persisted data

This will persist the data to the specified volume.  The following example will create a folder "devuser" in the current directory if it doesn't exist and map to /home/devuser in the container.

```
user=scott docker run -it -v $(pwd)/${user}:/home/${user} devdock:snapshot-002

```


### Push the image to the docker hub repository.
```
docker login -u <username>
```

#### Tag 
```
docker tag devdock:snapshot-002 schin8/devdock:snapshot-002
```

Since we're using both arm and x86 images[^2]

make sure docker desktop has the experimental features enabled.  Create a new builder instance; the default builder only supports a single platform.

```
docker buildx create --use
```

```
docker buildx build \
--push \
--platform linux/arm/v7,linux/arm64/v8,linux/amd64 \
--tag schin8/devdock:snapshot-002 .
```

The container is available on hub.docker.com at

```
https://hub.docker.com/r/schin8/devdock
```




---

[^1]:https://www.codemag.com/article/1811021/Docker-for-Developers
[^2]:https://blog.jaimyn.dev/how-to-build-multi-architecture-docker-images-on-an-m1-mac/





