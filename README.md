# homebrew-bao

Homebrew tap for [Bao](https://github.com/suhailparad/bao-claude), a desktop pet that shows
what Claude Code is doing.

```bash
brew install --cask suhailparad/bao/bao
open -a Bao        # first time: click Connect to link it to Claude Code
```

Apple silicon Macs (macOS 11+). `brew upgrade` picks up new releases; `brew uninstall bao`
removes the app and its Claude Code hooks (`--zap` also deletes `~/.bao`).
