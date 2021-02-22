# squid-docker
 Docker container for squid proxy.

## Setup Instructions
- Make a directory for squid
```bash
mkdir squid
```

- Copy the squid configuration file example from the container.

```bash
docker run --rm alphabet5/squid cat /example/squid.conf > squid/squid.conf
```

- Modify the squid.conf file for your application.

- Pull and run the container. 

```bash
docker pull squid 
docker run -d \
--name=squid \
-v /host/dir/whitelists:/whitelists \
-v /host/dir/squid/squid.conf:/etc/squid/squid.conf \
-p 3128:3128 \
alphabet5/squid
```

## Build instructions

```bash
git clone https://github.com/alphabet5/squid-docker.git
cd squid-docker
docker build .
```

