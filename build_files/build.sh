#!/bin/bash

set -ouex pipefail

### Install packages

# Apparently ZSTD is not included by default
dnf5 -y install zstd

# Damillora's Atelier Damillora uses Tailscale for connectivity
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf5 -y install tailscale

# Install Steam udev rules
dnf5 -y install steam-devices

# Install RPMFusion
dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf5 -y config-manager setopt fedora-cisco-openh264.enabled=1

# Install Codecs
dnf5 -y swap ffmpeg-free ffmpeg --allowerasing
#dnf5 -y update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf5 -y install intel-media-driver

# Install KSSHAskPass
dnf5 -y install ksshaskpass

# Remove repos
rm /etc/yum.repos.d/tailscale.repo

# Enable podman's socket by default
systemctl enable podman.socket

# Tweak os-release
sed -i '/^PRETTY_NAME/s/ (Kinoite)"$/-evey (Evernight Image)\"/' /usr/lib/os-release
sed -i '/^VERSION/s/ (Kinoite)"$/-evey (Evernight Image)"/' /usr/lib/os-release
sed -i 's|^VARIANT_ID=.*|VARIANT_ID=damillora-evernight|' /usr/lib/os-release
sed -i 's|^VARIANT=.*|VARIANT="Evernight Image"|' /usr/lib/os-release
sed -i "/^OSTREE_VERSION/s/'$/-evey'/" /usr/lib/os-release
