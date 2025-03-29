#
# SPDX-FileCopyrightText: 2025 Menno van der Graaf <mennovandergraaf@hotmail.com>
# SPDX-License-Identifier: MIT
#
from docker.io/library/mono:6.12.0.182-slim
run update-passwd && useradd -rm -d /home/nopsuser -s /bin/bash -u 1001 nopsuser && usermod -a -G dialout nopsuser
user nopsuser
copy NOTPSXSerial /home/nopsuser/NOTPSXSerial
workdir /home/nopsuser/NOTPSXSerial
entrypoint ["mono", "./nops.exe"]
