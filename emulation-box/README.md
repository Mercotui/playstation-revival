# Emulation Box

This is a test of getting a cheap single board computer to run a PS1 emulator.  
I got a cheap [Amedia X98Q](https://x96mini.com/products/factory-sale-tv-box-x98q-amlogic-s905w2-quad-core-android-11-hdr-4k-video-play-2gb-16gb-wifi-5g-smart-ott-set-top-box-for-home)
Android TV box, and want to load a tiny linux distro to run DuckStation.


## Flashing CoreELEC Linux

I found a potentially compatible firmware from:
https://coreelec.org/

Which I can flash it onto a USB-thumbdrive or SD-card using:

```bash
zcat <image path>.img.gz | sudo dd of=<device path> bs=4M status=progress oflag=sync
```

And making sure to select the right device tree:

```bash
cp <media>/COREELEC/device_trees/<device>.dtb <media>/COREELEC/dtb.img
```

## Building CoreELEC

Turns out I needed a custom device tree, which I have [commited here](https://github.com/Mercotui/CoreELEC_common_drivers/commit/ea2e9c460a9d292e1db97e48dfe6ffea3bae66dc).
To add that device tree to CoreELEC, apply the patch:

```bash
0001-Bump-Amlogic-common-drivers-for-X96Q-Devicetree.patch
```

Then use the container with all the needed build tools:

```bash
podman build -t coreelec-builder -f coreelec-build.containerfile .
podman run --rm -it --userns=keep-id -v ./CoreELEC:/home/builder:Z coreelec-builder
cd CoreELEC
```

And build the CoreELEC image for a X98Q:

```bash
PROJECT=Amlogic-ce DEVICE=Amlogic-no ARCH=aarch64 make image
```

Note: to clean build a package use:

```bash
PROJECT=Amlogic-ce DEVICE=Amlogic-no ARCH=aarch64 ./scripts/clean <package>
```
