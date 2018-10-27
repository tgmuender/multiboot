#!/usr/bin/env bash
# Partitions the given device (USB stick) with a single bootable partition and installs grub with the customized config

set -uxo pipefail

function installGrub {
    echo "Using partition: $PARTITION"

    local MOUNT_DIR='/mnt/multiboot'
    if [[ -d "$MOUNT_DIR" ]]; then
        rm -rf "$MOUNT_DIR"
    fi
    mkdir "$MOUNT_DIR"

    mount "$PARTITION" "$MOUNT_DIR"

    grub-install --force --no-floppy --boot-directory="$MOUNT_DIR/boot" --target=i386-pc "$DEVICE"

    cp grub.cfg "$MOUNT_DIR/boot/grub/grub.cfg"
    cp archlinux-2018.10.01-x86_64.iso "$MOUNT_DIR/archlinux-2018.10.01-x86_64.iso"
}

function partition {
    echo "Partitioning device: $DEVICE"

    wipefs -a "$DEVICE"

    parted "$DEVICE" mktable msdos
    parted "$DEVICE" mkpart primary fat32 0% 100%
    parted "$DEVICE" set 1 boot on

}

readonly DEVICE=$1
echo "Using device: $DEVICE"

partition

readonly PARTITION="${DEVICE}1"
mkfs.vfat -F 32 -n MULTIBOOT "$PARTITION"

installGrub
