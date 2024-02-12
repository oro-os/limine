#!/usr/bin/env bash
set -xeuo pipefail
cd "$(dirname "$0")"
rm -rf oro-aarch64
mkdir -p oro-aarch64/EFI/BOOT
cp \
	limine-uefi-cd.bin \
	limine-bios-cd.bin \
	limine-bios.sys \
	limine.cfg \
	oro-aarch64
cp /src/oro-os/kernel/target/aarch64-unknown-oro/${1-debug}/oro-limine-aarch64 oro-aarch64/oro-limine
cp /src/oro-os/kernel/target/aarch64-unknown-oro/${1-debug}/oro-kernel-aarch64 oro-aarch64/oro-kernel
cp BOOTAA64.EFI oro-aarch64/EFI/BOOT
xorriso \
	-as mkisofs \
	-b limine-bios-cd.bin \
	-no-emul-boot \
	-boot-load-size 4 \
	-boot-info-table \
	--efi-boot limine-uefi-cd.bin \
	-efi-boot-part \
	--efi-boot-image \
	--protective-msdos-label \
	"oro-aarch64" -o "oro-aarch64.iso"
./limine bios-install oro-aarch64.iso
