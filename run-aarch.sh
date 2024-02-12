#!/usr/bin/env bash
# To get the QEMU_EFI.fd file, you need the package `qemu-efi-aarch64`.
# If that's not available, you can get it here: https://releases.linaro.org/components/kernel/uefi-linaro/16.02/release/qemu64/
set -euo pipefail
QEMU_EFI="${QEMU_EFI-}"
if [ -z "$QEMU_EFI" ]; then
	QEMU_EFI="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"
fi
if [ ! -f "$QEMU_EFI" ]; then
	echo "no such QEMU_EFI.fd file: ${QEMU_EFI}" >&2
	exit 2
fi
exec qemu-system-aarch64 -M virt -cpu cortex-a57  -no-reboot -no-shutdown -serial stdio -cdrom ./oro-aarch64.iso -m 512 -smp cores=3 -bios "${QEMU_EFI}" "$@"
