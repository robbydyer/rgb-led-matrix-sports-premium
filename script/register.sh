#!/bin/bash
set -euo pipefail

ARCH="$(uname -m)"

tmp="$(mktemp -d /tmp/sportsinstall.XXXX)"
trap "rm -rf ${tmp}" EXIT

cd "${tmp}"

case "${ARCH}" in
aarch64|armv7l)
  echo "Installing sportsmatrix for ${ARCH}"
  latesturl="https://api.github.com/repos/robbydyer/rgb-led-matrix-sports-premium/releases/latest"

  curl -s "${latesturl}" | grep browser_download_url | grep -v deb | cut -d: -f2,3 | tr -d \" | wget -qi -
  ;;
armv6l)
  echo "Sorry, this architecture is not supported. You need a newer Pi with an armv7 processor- Pi 3, 4 or Pi Zero 2"
  ;;
*)
  echo "Unsupported architecture '${ARCH}'"
  exit 1
  ;;
esac

./devicesetup.${ARCH}

sudo systemctl restart sportsmatrix