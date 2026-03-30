# VyOS Stream Container builder & co

Inspired by https://github.com/sysoleg/vyos-container

This repos launches a github workflow when a **TAG** is created.

The **TAG** must be equal to the VyOS Stream release for which a container image shall be built. I.e., `2026.03` will build a container starting from `vyos-2026.03-generic-amd64.iso`. The container image will have the same tag, and `latest` will point to the latest build.

## Manual Build

```
docker build -t ssasso/vyos-stream-container:latest .
```

## Running

```
docker run -d --name vyos --privileged -v /lib/modules:/lib/modules ssasso/vyos-stream-container:latest
```

## Logging in

```
docker exec -it vyos su vyos
```
