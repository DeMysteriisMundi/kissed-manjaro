FROM manjarolinux/base:latest

RUN \
    useradd -d /home/isobuilder -m -s /bin/bash \
        -U -G wheel isobuilder && \
    pacman -Sy && \
    pacman -S --noconfirm \
	lsb-release \
	manjaro-release \
	manjaro-tools-base-git \
	manjaro-tools-iso-git  \
	manjaro-tools-pkg-git  \
	manjaro-tools-yaml-git

COPY sudoers /etc/sudoers

USER isobuilder

