#!/bin/bash

# Enable podman socket
systemctl enable podman.socket

# Setup signing for Resna
## Copy public key
mkdir -p /etc/pki/containers
cp /ctx/cosign.pub /etc/pki/containers/evernight.pub
