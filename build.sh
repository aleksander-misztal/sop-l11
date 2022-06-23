#!/usr/bin/bash

nasm bootloader.asm -f bin -o bootloader
truncate -s 1M bootloader

