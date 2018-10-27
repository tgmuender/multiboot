#!/usr/bin/env bash
# Create (single) partition and file system before starting this script

set -uxo pipefail

readonly DEVICE=$1
readonly PARTITION="${DEVICE}1"

echo "Using device: $DEVICE"
echo "Using partition: $PARTITION"

readonly MOUNT_DIR='/mnt/multiboot'
if [[ -d "$MOUNT_DIR" ]]; then
    rm -rf "$MOUNT_DIR"
fi
mkdir "$MOUNT_DIR"

mount "$PARTITION" "$MOUNT_DIR"

grub-install --force --no-floppy --boot-directory="$MOUNT_DIR/boot" --target=i386-pc "$DEVICE"

cp grub.cfg "$MOUNT_DIR/boot/grub/grub.cfg"

cp archlinux-2018.10.01-x86_64.iso "$MOUNT_DIR/archlinux-2018.10.01-x86_64.iso"