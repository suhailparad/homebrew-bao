cask "bao" do
  version "0.1.0"
  sha256 "3f3f5268f2318970ff1ac09d47e9b77f740034826a38b25cc7823f22d83ee7f6"

  url "https://github.com/suhailparad/bao-claude/releases/download/v#{version}/Bao-#{version}-arm64.dmg"
  name "Bao"
  desc "Desktop pet that shows what Claude Code is doing"
  homepage "https://github.com/suhailparad/bao-claude"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  app "Bao.app"
  binary "#{appdir}/Bao.app/Contents/MacOS/Bao", target: "bao"

  # Not notarized yet: clear the quarantine flag so the first launch isn't blocked.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Bao.app"],
        must_succeed: false
  end

  # Remove Claude Code hooks only if they point into this app (never a source install's).
  uninstall quit:   "dev.bao.pet",
            script: {
              executable: "/bin/sh",
              args:       [
                "-c",
                'S="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/settings.json"; ' \
                'if grep -q "Bao.app/Contents/MacOS/bao-hook" "$S" 2>/dev/null; then ' \
                '"$1" uninstall-hooks; fi; true',
                "sh",
                "#{appdir}/Bao.app/Contents/MacOS/Bao",
              ],
            }

  zap trash: "~/.bao"

  caveats <<~EOS
    Open Bao once (from Applications or `open -a Bao`) and click Connect
    to link it to Claude Code. Then start a new `claude` session.
  EOS
end
