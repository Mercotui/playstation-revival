#!/usr/bin/env bash
#
# SPDX-FileCopyrightText: 2025 Menno van der Graaf <mennovandergraaf@hotmail.com>
# SPDX-License-Identifier: MIT
#

git clone git@github.com:JonathanDotCel/NOTPSXSerial.git
podman build -t nops -f nops.containerfile
