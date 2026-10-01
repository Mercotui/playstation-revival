# SPDX-FileCopyrightText: 2026 Menno van der Graaf <mennovandergraaf@hotmail.com>
# SPDX-License-Identifier: MIT
FROM registry.fedoraproject.org/fedora:latest

# Install build dependencies
RUN dnf update -y && \
    dnf install -y \
      git bash bc bdftopcf bzip2 curl diffutils gawk gcc gperf gzip file glibc-static java-latest-openjdk-devel \
      libstdc++-static libxslt lzop make ncurses-devel patch patchutils perl perl-JSON perl-Parse-Yapp perl-XML-Parser \
      rdfind rsync rpcgen sed tar unzip xz xorg-x11-font-utils zip zstd cpio which xxd && \
    dnf clean all

# Add builder user
RUN useradd -m builder

USER builder
WORKDIR /home/builder
