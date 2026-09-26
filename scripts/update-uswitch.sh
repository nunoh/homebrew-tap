#!/bin/bash
# Write Casks/uswitch.rb for the latest uSwitch release. The checksum comes
# from the release's SHA256SUMS.txt, so the DMG is never re-downloaded.
set -euo pipefail

repo=nunoh/uSwitch
cd "$(dirname "$0")/.."

if ! tag=$(gh release view --repo "$repo" --json tagName --jq .tagName 2>/dev/null); then
  echo "no uSwitch release yet"
  exit 0
fi
version=${tag#v}
dmg="uSwitch-v${version}-arm64.dmg"

# The release exists before its assets finish uploading; try again next run.
if ! sums=$(gh release download "$tag" --repo "$repo" --pattern SHA256SUMS.txt --output - 2>/dev/null); then
  echo "no SHA256SUMS.txt on $tag yet"
  exit 0
fi
sha=$(awk -v f="$dmg" '$2 == f { print $1 }' <<<"$sums")
if [ -z "$sha" ]; then
  echo "$dmg not listed in SHA256SUMS.txt on $tag"
  exit 0
fi

sed -e "s/__VERSION__/$version/" -e "s/__SHA256__/$sha/" templates/uswitch.rb > Casks/uswitch.rb
echo "uswitch $version ($sha)"
