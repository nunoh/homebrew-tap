cask "uswitch" do
  version "0.3.0"
  sha256 "f3394f883574a847ba226800dc36ac0d53246b1c4e3596761d7af2a0e061ab7c"

  url "https://github.com/nunoh/uSwitch/releases/download/v#{version}/uSwitch-v#{version}-arm64.dmg"
  name "uSwitch"
  desc "Tiny window switcher with live thumbnails"
  homepage "https://github.com/nunoh/uSwitch"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "uSwitch.app"

  uninstall quit: "com.nh.uswitch"

  zap trash: "~/Library/Preferences/com.nh.uswitch.plist"

  caveats <<~EOS
    uSwitch is ad-hoc signed and not notarized. On first launch, open
    System Settings → Privacy & Security, click Open Anyway, then Open.

    It needs Accessibility and Screen Recording permission. macOS may ask
    again after an upgrade.
  EOS
end
