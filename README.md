# nunoh/homebrew-tap

Homebrew casks for [nunoh](https://github.com/nunoh)'s apps.

```sh
brew install --cask nunoh/tap/uswitch
```

| Cask | App |
|------|-----|
| `uswitch` | [uSwitch](https://github.com/nunoh/uSwitch) — tiny window switcher with live thumbnails (Apple Silicon, macOS 13+) |

## How it updates

`.github/workflows/update-uswitch.yml` runs every hour. It reads the latest uSwitch release, takes the DMG checksum from its `SHA256SUMS.txt`, and commits `Casks/uswitch.rb` when the version changed. Run it from the Actions tab to update at once.
