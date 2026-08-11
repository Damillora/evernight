#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Apparently ZSTD is not included by default
dnf5 -y install zstd

# Damillora's Atelier Damillora uses Tailscale for connectivity
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf5 -y install tailscale

# Install Steam udev rules
dnf5 -y install steam-devices

# Install GCC C and C++ compilers
dnf5 -y install gcc gcc-c++

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

#### Example for enabling a System Unit File

systemctl enable podman.socket

# Tweak os-release
sed -i '/^PRETTY_NAME/s/ (Kinoite)"$/  (Evernight Image)\"/' /usr/lib/os-release
sed -i '/^VERSION/s/ (Kinoite)"$/ (Evernight Image)"/' /usr/lib/os-release
sed -i 's|^VARIANT_ID=.*|VARIANT_ID=damillora-evernight|' /usr/lib/os-release
sed -i 's|^VARIANT=.*|VARIANT="Evernight Image"|' /usr/lib/os-release
#sed -i "/^OSTREE_VERSION/s/'$/'/" /usr/lib/os-release

