# multiboot

The script creates a bootable USB stick and installs Grub with the customized config.


1. Use lsblk to find the USB stick, e.g. /dev/sdb
    ```bash
    user@host lsblk
    ```

1. Start the script with the identified device as 1st parameter
    ```bash
    user@host sudo ./usb.sh /dev/sdb
    ```

1. Unmount the created partition
    ```bash
    user@host sudo umount /dev/sdb1
    ```
