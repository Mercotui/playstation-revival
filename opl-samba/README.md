# Running Samba for PS2 OPL

To load game ISOs over the network using OPL on my PS2 slim, I run a samba container.

```bash
podman build -t opl-samba -f samba.containerfile

sudo sysctl -w net.ipv4.ip_unprivileged_port_start=445
sudo firewall-cmd --add-port=445/tcp
podman run -d -p 445:445 -v ./smb.conf:/etc/samba/smb.conf:ro,Z -v <share-path>:/shared:ro,z opl-samba
```

Replace `<share-path>` with the full path of the directory you want to serve.

## OPL data

The OPL share needs to be structured, OPL would supposedly create this structure itself upon first connecting to
the SMB share, but mounting it as read-only blocks that.
Instead, I've manually set up the needed dirs using the Python OPL Manager `pyoplm` tool, using a container:

```bash
podman build -t opl-manager -f pyoplm.containerfile
podman run --rm -v <share-path>:/shared:z opl-manager init
```

You can also just create the directories by hand, but this tool has other interesting features that can help with OPL.

We can use a [local backup](https://oplmanager.com/site/?backups) of the OPL Manager database to supply artwork and
title information to `pyoplm`. Just extract the backup zip to a directory, which we shall refer to as `<oplm-db-path>`.

To configure `pyoplm` we add a `<share-path>/pyoplm.ini` with the contents:

```ini
[STORAGE]
# This is the path where we mount the DB in our container
location = /oplm-db
```

### ISOs

I put all my game ISOs under `<share-path>/DVD`.
Using `pyoplm` and the downloaded database, we can rename them to the format OPL expects, and supply the artwork.

```bash
podman run --rm -v <share-path>:/shared:z -v <oplm-db-path>:/oplm-db:Z opl-manager storage rename
podman run --rm -v <share-path>:/shared:z -v <oplm-db-path>:/oplm-db:Z opl-manager storage artwork
```
