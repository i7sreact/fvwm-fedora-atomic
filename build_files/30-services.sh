#!/bin/bash

set -ouex pipefail

## Enable CPU Frequency Regulator
systemctl enable auto-cpufreq.service

## Enable connection services
systemctl enable NetworkManager.service
systemctl enable ModemManager.service
systemctl enable firewalld.service
systemctl enable bluetooth.service

## Enable printer services
systemctl enable cupsd.service

## Enable containers
systemctl enable podman.socket
systemctl enable docker.service

## Enable display manager
mkdir -p /var/lib/lightdm /var/lib/lightdm-data
systemctl enable lightdm.service

## Enable fingerprint reader
systemctl enable open-fprintd-resume.service
systemctl enable open-fprintd-suspend.service
systemctl enable open-fprintd.service
systemctl enable python3-validity.service

## Enable autoupdates
systemctl enable rpm-ostreed-automatic.timer
systemctl enable podman-auto-update.timer
systemctl --global enable podman-auto-update.timer
systemctl --global enable flatpak-user-update.timer
systemctl enable flatpak-system-update.timer
