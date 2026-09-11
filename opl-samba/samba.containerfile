#
# SPDX-FileCopyrightText: 2026 Menno van der Graaf <mennovandergraaf@hotmail.com>
# SPDX-License-Identifier: MIT
#
from docker.io/library/alpine:3.24
run apk add --no-cache samba
entrypoint ["smbd", "--foreground", "--no-process-group"]
