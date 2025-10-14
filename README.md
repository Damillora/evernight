# Evernight

> Damillora's Ever-nightly system image

A Fedora Kinoite-based [bootc](https://github.com/bootc-dev/bootc) image, serving as the workstation image of Atelier Damillora.

## Included software

Fedora Kinoite, plus:
### System packages
* `zstd`
* `tailscaled`
* `ksshaskpass`
* `steam-devices`
* RPMFusion codecs

## Installation

First, [Install Kinoite](https://docs.fedoraproject.org/en-US/fedora-kinoite/installation/).

From the newly installed Fedora Kinoite installation, rebase to an unsigned image first, then reboot:
```sh
sudo bootc switch ghcr.io/damillora/evernight:latest
```

After rebooting, rebase to a signed image:
```sh
sudo bootc switch --enforce-container-sigpolicy ghcr.io/damillora/evernight:latest
```

## Acknowledgements

This repo builds upon the [Universal Blue image template](https://github.com/ublue-os/image-template), with additional customization.
