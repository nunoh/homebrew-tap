cask "uswitch" do
  version "0.5.0"
  sha256 "15126a7c8cf4bcfd44a3051004244416dc2124013b067b8a15142f248a8bf21e"

  url "https://github.com/nunoh/uSwitch/releases/download/v#{version}/uSwitch-v#{version}-arm64.dmg"
  name "uSwitch"
  desc "Tiny window switcher with live thumbnails"
  homepage "https://github.com/nunoh/uSwitch"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "uSwitch.app"

  # uSwitch is self-signed, not notarized: without this, Gatekeeper blocks the
  # first launch until the user approves it in System Settings.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/uSwitch.app"]
  end

  uninstall quit: "com.nh.uswitch"

  zap trash: "~/Library/Preferences/com.nh.uswitch.plist"

  caveats <<~EOS
    uSwitch needs Accessibility and Screen Recording permission. Grant both
    in System Settings → Privacy & Security on first launch.
  EOS
end
