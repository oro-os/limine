#!/usr/bin/env sh
exec qemu-system-x86_64 -cdrom ./oro-x86_64.iso -serial stdio -no-reboot -no-shutdown -smp cores=16 "$@"
