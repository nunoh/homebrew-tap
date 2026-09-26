cask "uswitch" do
  version "0.3.1"
  sha256 "660d36ff34966ae44b88427acab8773db726d076e55c4f9a698c6083367d7e0f"

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
