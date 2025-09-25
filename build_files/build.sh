#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# ZSH is Damillora's main shell
dnf5 -y install zsh

# Apparently ZSTD is not included by default
dnf5 -y install zstd

# Install Kate
dnf5 -y install kate

# Damillora's Atelier Damillora uses Tailscale for connectivity
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf5 -y install tailscale

# Install RPMFusion
dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 
dnf5 -y config-manager setopt fedora-cisco-openh264.enabled=1

# Install Steam
dnf5 -y install steam steam-devices

# Install Codecs
dnf5 -y swap ffmpeg-free ffmpeg --allowerasing
#dnf5 -y update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf5 -y install intel-media-driver

# Remove repos
rm /etc/yum.repos.d/tailscale.repo
# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

# Tweak os-release
sed -i '/^PRETTY_NAME/s/ (Kinoite)"$/-evey-'"${BUILD_DATE}"' (Evernight Image)\"/' /usr/lib/os-release
sed -i '/^VERSION/s/ (Kinoite)"$/-evey-'"${BUILD_DATE}"' (Evernight Image)"/' /usr/lib/os-release
sed -i 's|^VARIANT_ID=.*|VARIANT_ID=damillora-evernight|' /usr/lib/os-release
sed -i 's|^VARIANT=.*|VARIANT="Evernight Image"|' /usr/lib/os-release
sed -i "/^OSTREE_VERSION/s/'$/-evey-${BUILD_DATE}'/" /usr/lib/os-release
