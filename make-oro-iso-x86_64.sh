#!/usr/bin/env bash
set -xeuo pipefail
cd "$(dirname "$0")"
rm -rf oro-x86_64
mkdir oro-x86_64
cp \
	limine-uefi-cd.bin \
	limine-bios-cd.bin \
	limine-bios.sys \
	limine.cfg \
	oro-x86_64
cp /src/oro-os/kernel/target/x86_64-unknown-oro/${1-debug}/oro-limine-x86_64 oro-x86_64/oro-limine
cp /src/oro-os/kernel/target/x86_64-unknown-oro/${1-debug}/oro-kernel-x86_64 oro-x86_64/oro-kernel
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
	"oro-x86_64" -o "oro-x86_64.iso"
./limine bios-install oro-x86_64.iso
