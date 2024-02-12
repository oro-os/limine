#!/usr/bin/env bash
set -xeuo pipefail
cd "$(dirname "$0")"
rm -rf oro-x86_64
mkdir -p oro-x86_64/boot/limine
cp \
	limine-uefi-cd.bin \
	limine-bios-cd.bin \
	limine-bios.sys \
	limine.conf \
	oro-x86_64/boot/limine
cp /src/oro-os/kernel/target/x86_64-unknown-oro/${1-debug}/oro-limine-x86_64 oro-x86_64/oro-limine-x86-64
cp /src/oro-os/kernel/target/x86_64-unknown-oro/${1-debug}/oro-kernel-x86_64 oro-x86_64/oro-kernel-x86_64
cp /src/oro-os/oro/target/x86_64-unknown-none/release/mod-boot-logger oro-x86_64/M-6TD9M6QGRUGMZEH3HCRMGW0D1
mkdir -p oro-x86_64/EFI/BOOT
cp BOOTX64.EFI BOOTIA32.EFI oro-x86_64/EFI/BOOT
xorriso \
	-as mkisofs \
	-R -r -J \
	-b boot/limine/limine-bios-cd.bin \
	-no-emul-boot \
	-boot-load-size 4 \
	-boot-info-table \
	-hfsplus \
	-apm-block-size 2048 \
	--efi-boot boot/limine/limine-uefi-cd.bin \
	-efi-boot-part \
	--efi-boot-image \
	--protective-msdos-label \
	"oro-x86_64" -o "oro-x86_64.iso"
./limine bios-install oro-x86_64.iso
