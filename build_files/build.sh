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

# Damillora's Atelier Damillora uses Tailscale for connectivity
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf5 -y install tailscale


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
sed -i '/^PRETTY_NAME/s/"$/ (Evernight Image)"/' /usr/lib/os-release
sed -i 's|^VARIANT_ID=.*|VARIANT_ID=damillora-evernight|' /usr/lib/os-release
sed -i 's|^VARIANT=.*|VARIANT="Evernight Image"|' /usr/lib/os-release
