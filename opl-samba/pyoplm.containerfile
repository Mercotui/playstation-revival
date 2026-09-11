from docker.io/library/debian:12-slim

run apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip pipx && \
    rm -rf /var/lib/apt/lists/*

run pipx install pyoplm

env PATH="/root/.local/bin:${PATH}"
env PYOPLM_OPL_DIR=/shared

entrypoint ["pyoplm"]
