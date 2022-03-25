# squid-docker
 Docker container for squid proxy.

## Setup Instructions
- Make a directory for squid and the example whitelists.
```bash
mkdir squid
```

- Copy the squid configuration file example from the container.

```bash
docker run --rm alphabet5/squid cat /example/squid.conf > squid/squid.conf
docker run --rm alphabet5/squid cat /example/whitelists/rockwell.txt > squid/whitelists/rockwell.txt
docker run --rm alphabet5/squid cat /example/whitelists/symantec.txt > squid/whitelists/symantec.txt
docker run --rm alphabet5/squid cat /example/whitelists/windows_updates.txt > squid/whitelists/windows_updates.txt
```

- Modify the squid.conf file for your application.

- Pull and run the container. 

```bash
docker pull alphabet5/squid 
docker run -d \
--name=squid \
--restart=always \
-v /home/user/squid/whitelists:/whitelists \
-v /home/user/squid/squid.conf:/etc/squid/squid.conf \
-p 3128:3128 \
alphabet5/squid
```

## Build instructions

```bash
git clone https://github.com/alphabet5/squid-docker.git
cd squid-docker
docker build .
```

## Changelog

### 0.0.2

- Made symlinks to write logs to stdout.