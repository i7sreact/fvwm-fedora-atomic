#!/bin/bash

set -ouex pipefail

## Variables
CTXICON="/ctx/files/icons"
ICONDIR="/usr/share/icons"

## Build Stage
mkdir -p /tmp
mkdir -p /var/roothome
mkdir -p /usr/share/themes 
mkdir -p /usr/share/icons

dnf5 -y install git cmake qt5-qtbase-devel qt6-qtbase-devel rpmdevtools rpm-sign \
	rpmlint aspell-fr enchant2-aspell

## Enable repositories
# Repositories
dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
dnf5 config-manager addrepo --from-repofile=https://dl.winehq.org/wine-builds/fedora/44/winehq.repo
# COPR Repositories
dnf5 -y copr enable @xlibre/xlibre-xserver
dnf5 -y copr enable sneexy/python-validity
# Repositories configurations
dnf5 config-manager setopt fedora-cisco-openh264.enabled=1

## Install System components
# CPU Frequency regulator (auto-cpufreq)
cd /tmp
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && ./auto-cpufreq-installer
cd

# Flatpak
dnf5 -y install flatpak flatpak-spawn

# Fingerprint reader (python-validity)
dnf5 -y install open-fprintd fprintd-clients fprintd-clients-pam python3-validity

# Docker
dnf5 -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Utils
dnf5 -y install brightnessctl cabextract dbus-daemon dbus-tools e2fsprogs btrfs-progs dosfstools \
	mtools xfsprogs ntfs-3g jfsutils squashfs-tools udftools mtd-utils f2fs-tools exfatprogs \
	lvm2 cryptsetup pciutils usbutils usb_modeswitch ImageMagick powerstat p7zip zip unzip unrar \
	curl wget

# Framework components
dnf5 -y install qt5-qtbase qt5-qtbase-gui qt6-qtbase qt6-qtbase-gui gtk-murrine-engine

# cd /tmp
# https://github.com/luigifab/globalqss.git
# cd globalqss && ./scripts/fedora/rpm.sh
# rpm -ivh --nodigest --nofiledigest
# cd

# Themes and icons
dnf5 -y install human-theme-gtk gnome-icon-theme mate-icon-theme dmz-cursor-theme

cd /tmp
https://github.com/ducakar/openzone-cursors.git
cd openzone-cursors && make install
# curl -LO https://gitlab.com/blackcrack/tango-svg-plasma5up-v3-202507-blackysgate.de/-/raw/main/2025.08.24-16-12.TangoSVG-V3-plasma5up-blackysgate.de-icontheme.tar.gz
# tar xvf $CTXICON/2026.04.25-14-42.TangoSVG-V3-plasma5up-blackysgate.de-icontheme.tar.gz \
# 	-C $ICONDIR
# tar xvf $CTXICON/2026.04.25-14-03.KrystalSVG-Plasma5up-scalable-icontheme-blackysgate.de.tar.gz \
# 	-C $ICONDIR
# tar xvf $CTXICON/2023.10.10-16-58.Real-Time-Kde4-iconstheme-scaled-Blackysgate.de.tar.gz \
# 	-C $ICONDIR
# tar xvf $CTXICON/2026.04.25-15-06.Win2kSVG-plasma5up-scalable-icontheme-blackysgate.de.tar.gz \
# 	-C $ICONDIR
# tar xvf $CTXICON/2026.04.25-15-31.WinXPSVG-plasma5up-scalable-icontheme-blackysgate.de.tar.gz \
# 	-C $ICONDIR
# tar xvf $CTXICON/2026.04.25-15-46.Win7-plasma5up-scalable-icontheme-blackysgate.de.tar.gz \
# 	-C $ICONDIR
# mv $ICONDIR/TangoSVG-V3-plasma5up-blackysgate.de-icontheme $ICONDIR/Tango_V3
# mv $ICONDIR/KrystalSVG-Plasma5up-scalable-icontheme-blackysgate.de $ICONDIR/Krystal
# mv $ICONDIR Real-Time-Kde4-iconstheme-scaled-Blackysgate.de $ICONDIR/Real_Time
# mv $ICONDIR/Win2kSVG-plasma5up-scalable-icontheme-blackysgate.de $ICONDIR/Win2k
# mv $ICONDIR/WinXPSVG-plasma5up-scalable-icontheme-blackysgate.de $ICONDIR/WinXP
# mv $ICONDIR/Win7-plasma5up-scalable-icontheme-blackysgate.de $ICONDIR/Win7
cd

## Install Network (Network Manager)
dnf5 -y install NetworkManager ModemManager mobile-broadband-provider-info

## Install Audio (Pipewire)
dnf5 -y install wireplumber pipewire pipewire-utils pipewire-v4l2 pipewire0.2-libs \
	pipewire-alsa pipewire-pulseaudio pipewire-jack-audio-connection-kit pipewire-gstreamer \
	pipewire-config-raop pipewire-config-rates pipewire-config-upmix \
	pipewire-module-ffado pipewire-module-filter-chain-lv2 pipewire-module-filter-chain-onnx \
	pipewire-module-filter-chain-sofa pipewire-module-roc pipewire-module-x11 \
	pipewire-plugin-jack pipewire-plugin-libcamera pipewire-plugin-vulkan \
	alsa-firmware

## Install Bluetooth (Bluez)
dnf5 -y install bluez bluez-tools bluez-cups bluez-hid2hci bluez-mesh bluez-obexd bluez-hcidump

## Install CUPS and drivers
dnf5 -y install cups cups-browsed cups-filters cups-pdf cups-pk-helper cups-x2go
dnf5 -y install gutenprint-cups dymo-cups-drivers ptouch-driver c2esp epson-inkjet-printer-escpr \
	epson-inkjet-printer-printer-escpr2 iscan-firmware foo2hp pnm2ppa foomatic-db-ppds tuned-ppd

## Install Firewall (Firewalld)
dnf5 install -y firewalld

## Install FVWM
dnf5 -y install xlibre-server xlibre-xf86-input-evdev xlibre-xf86-input-libinput \
	xlibre-xf86-input-synaptics xlibre-xf86-wacom xlibre-xf86-video-amdgpu xlibre-xf86-video-intel \
	xlibre-xf86-video-nouveau xlibre-xf86-video-qxl xlibre-xf86-video-vmware vulkan-tools \
	vulkan-validation-layers
dnf5 -y install xrandr xprop xinput xsetroot
dnf5 -y install lightdm lightdm-gtk-greeter light-locker xscreensaver
dnf5 -y install fvwm3 stalonetray dunst
dnf5 -y install xdg-utils xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-gtk \
	xdg-desktop-portal-lxqt xdg-desktop-portal-xapp

## Install necessary software
# System Main software
dnf5 config-manager setopt install_weak_deps=0
dnf5 -y install xfce4-terminal nm-connection-editor firewall-config blueman system-config-printer arandr \
	nemo nemo-extensions nemo-blueman nemo-compare gtkhash-nemo engrampa qps nwg-look plasma-discover \
	plasma-discover-flatpak plasma-discover-notifier pavucontrol
dnf5 -y install eom atril vlc mate-calc gpick scrot vim-X11 
dnf5 -y install pasystray battray network-manager-applet
dnf5 config-manager unsetopt install_weak_deps
cd /tmp
git clone https://github.com/aarnt/qt-sudo
cd qt-sudo && qmake6
make && make install
cd


# Media Codecs
dnf5 -y install @multimedia
dnf5 -y install intel-media-driver
dnf5 -y swap ffmpeg-free ffmpeg --allowerasing
dnf5 config-manager setopt install_weak_deps=0
dnf5 -y update @multimedia --exclude=PackageKit-gstreamer-plugin
dnf5 config-manager unsetopt install_weak_deps

# Fonts
dnf5 -y install fontconfig
dnf5 -y install default-fonts
dnf5 -y install google-noto-fonts-all google-noto-emoji-fonts dejavu-fonts-all liberation-fonts-all \
	alef-fonts amiri-fonts edwin-fonts jsmath-fonts wine-fonts
dnf5 -y install google-noto-sans-cjk-fonts google-noto-serif-cjk-fonts google-noto-sans-vf-fonts \
	google-noto-serif-cjk-vf-fonts adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts \
	adobe-source-han-sans-kr-fonts adobe-source-han-serif-kr-fonts adobe-source-han-sans-cn-fonts \
	adobe-source-han-serif-cn-fonts adobe-source-han-sans-tw-fonts adobe-source-han-serif-tw-fonts \
	adobe-source-han-mono-fonts wqy-zenhei-fonts
cd /tmp
curl -LO https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
rpm -ivh --nodigest --nofiledigest msttcore-fonts-installer-2.6-1.noarch.rpm
cd

# WINE
dnf5 -y install winehq-staging

# Android Tools
dnf5 -y install android-tools

## Configuring flatpak and global packages
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo


## Cleanup of pkgs
rm -rf /tmp/*
