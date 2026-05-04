#!/bin/bash

set -ouex pipefail

## Remove repos
rm -f /etc/yum.repos.d/negativo17-fedora-nvidia.repo
rm -f /etc/yum.repos.d/negativo17-fedora-multimedia.repo
rm -f /etc/yum.repos.d/negativo17-fedora-nvidia-lts.repo
rm -f /etc/yum.repos.d/fedora-negativo17.repo
rm -f /etc/yum.repos.d/eyecantcu-supergfxctl.repo
rm -f /etc/yum.repos.d/_copr_ublue-os-akmods.repo
rm -f /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo
rm -f /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo.rpmsave
rm -f /etc/yum.repos.d/nvidia-container-toolkit.repo
rm -f /etc/yum.repos.d/fedora-cisco-openh264.repo

## Install Android Udev rules
LATEST_ANDROID_UDEV_RULES_COMMIT="e62577fade0e79a965edfff732b88f228266cb0b" # 20250525
curl -OL "https://github.com/M0Rf30/android-udev-rules/archive/${LATEST_ANDROID_UDEV_RULES_COMMIT}.tar.gz"
tar xvf "${LATEST_ANDROID_UDEV_RULES_COMMIT}.tar.gz" --strip-components=1

install -m 644 51-android.rules /etc/udev/rules.d/
mkdir -p /usr/lib/sysusers.d/
install -m 644 android-udev.conf /usr/lib/sysusers.d/.

## Regenerate initramfs
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(\d+\.\d+\.\d+)' | sed -E 's/kernel-//')"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
chmod 0600 "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"

## Removing and cleaning unneeded packages
dnf5 -y autoremove
