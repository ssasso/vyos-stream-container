FROM ubuntu:latest AS builder
ARG VERSION=2026.03

RUN apt update && apt install -y wget p7zip-full squashfs-tools

RUN wget -qO out.iso "https://community-downloads.vyos.dev/stream/${VERSION}/vyos-${VERSION}-generic-amd64.iso"

RUN mkdir rootfs && 7z e out.iso filesystem.squashfs -r && \
	unsquashfs -f -d rootfs/ filesystem.squashfs

RUN cd rootfs && \
	sed -i 's/^LANG=.*$/LANG=C.UTF-8/' etc/default/locale && \
	rm -rf boot/* lib/firmware lib/modules/* && \
	ln -s /opt/vyatta/etc/config config && \
	ln -s /dev/null etc/systemd/system/atopacct.service && \
	ln -s /dev/null etc/systemd/system/hv-kvp-daemon.service

FROM scratch
COPY --from=builder rootfs ./
COPY hacks/hostnamectl /usr/local/bin
CMD ["/sbin/init"]
