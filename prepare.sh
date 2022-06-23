#!/bin/bash
rm bootloader.vdi
vboxmanage list hdds | grep ^UUID | awk '{print $2}' | xargs -I% VBoxManage closemedium disk "%" --delete
VBoxManage convertfromraw bootloader bootloader.vdi --format VDI
