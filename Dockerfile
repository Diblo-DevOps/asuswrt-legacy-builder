FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive
ENV PATH $PATH:/opt
ENV SOURCE_FOLDER /source

RUN \
    # Enable support for 32-bit libraries
    dpkg --add-architecture i386 && \
    # Update the package index
    apt-get update && \
    # Install required packages
    apt-get -y --no-install-recommends install \
        libtool-bin cmake libproxy-dev uuid-dev liblzo2-dev autoconf automake bash bison \
        bzip2 diffutils file flex m4 g++ gawk groff-base libncurses-dev libtool libslang2 make patch perl pkg-config shtool \
        subversion tar texinfo zlib1g zlib1g-dev gettext libexpat1-dev libssl-dev cvs gperf unzip \
        python libxml-parser-perl gcc-multilib gconf-editor libxml2-dev g++-multilib gitk libncurses5 mtd-utils \
        libncurses5-dev libvorbis-dev git autopoint autogen sed build-essential intltool libelf1:i386 libglib2.0-dev \
        xutils-dev lib32z1-dev lib32stdc++6 xsltproc gtk-doc-tools automake1.11 wget && \
    # Install editing tools
    apt-get -y --no-install-recommends install nano diffutils binwalk squashfs-tools liblzma-dev && \
    git clone https://github.com/devttys0/sasquatch.git /tmp/sasquatch && \
    cd /tmp/sasquatch && \
    ./build.sh && \
    rm -R /tmp/sasquatch && \
    # Switch from sh to bash
    echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure dash && \
    # Clean up
    apt-get -y autoremove && \
    apt-get -y autoclean && \
    rm -Rf /var/cache/apt/archives/*

COPY src/setup-src /opt/
RUN chmod 755 /opt/setup-src

COPY src/envs /opt/envs

RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc \
    ; echo "This Docker image would allow you to build AsusWRT legacy firmware" > /etc/motd \
    ; echo "v380.70 for the models RT-N16, RT-N66U, RT-AC66U and RT-AC56U." > /etc/motd \
    ; echo "To download source and apply patches, please run" >> /etc/motd \
    ; echo " 'setup-src'" >> /etc/motd \
    ; echo "To initialize correctly environment, please run" >> /etc/motd \
    ; echo " 'source /opt/envs/[rt-n16, rt-n66u, rt-ac66u, rt-ac56u]'" >> /etc/motd \
    ; echo "Warning: This image is only tested with RT-AC66U!" >> /etc/motd

WORKDIR $SOURCE_FOLDER

CMD ["bash"]
