#!/usr/bin/env sh
# QEMU_EFI.fd pulled from: https://releases.linaro.org/components/kernel/uefi-linaro/16.02/release/qemu64/
exec qemu-system-aarch64 -M virt -cpu cortex-a57  -no-reboot -no-shutdown -serial stdio -cdrom ./oro-aarch64.iso -m 512 -smp cores=4 -bios ./QEMU_EFI.fd
