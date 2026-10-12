# Coddy Web App — Omarchy Shell Plugin

> Launch [Coddy](https://github.com/NeuralDeep/coddy) AI assistant as a
> standalone desktop window from the Omarchy top bar.

![Omarchy Bar](https://raw.githubusercontent.com/NeuralDeep/coddy-omarchy-webapp/main/screenshots/bar.png)

## ✨ Features

- **One-click launch** — click the Coddy icon in the Omarchy top bar
- **PWA-like experience** — opens Coddy in Chrome/Chromium app mode
  (no address bar, no tabs, no browser UI)
- **Middle-click fallback** — opens in the default browser if needed
- **Configurable port** — works with any Coddy port via plugin settings
- **Window size control** — optionally set a fixed window size

## 📦 Installation

### From GitHub (recommended)

```bash
# Add the plugin and enable it in one command
omarchy plugin add https://github.com/NeuralDeep/coddy-omarchy-webapp --enable
```

### Manual installation

```bash
# Clone this repository
git clone https://github.com/NeuralDeep/coddy-omarchy-webapp.git
mv coddy-omarchy-webapp ~/.config/omarchy/plugins/coddy-webapp

# Enable and place on the bar
omarchy plugin enable coddy-webapp right
```

## ⚙️ Configuration

### Port

By default Coddy runs on port `12345`. If you changed it, update the
plugin setting:

```bash
omarchy plugin settings coddy-webapp set port=8080
```

Or edit `~/.config/omarchy/plugins/coddy-webapp/manifest.json` and
change the `default` value for the port setting.

### Window size (app mode)

To force a fixed window size when Coddy opens:

```bash
omarchy plugin settings coddy-webapp set width=1200
omarchy plugin settings coddy-webapp set height=800
```

### Reorder on the bar

```bash
# Move to center
omarchy plugin enable coddy-webapp center:0

# Move to left side
omarchy plugin enable coddy-webapp left:0

# Disable (remove from bar)
omarchy plugin disable coddy-webapp
```

## 🗑️ Uninstall

```bash
omarchy plugin disable coddy-webapp
omarchy plugin remove coddy-webapp --yes
```

## 🔄 Update

```bash
omarchy plugin update coddy-webapp
```

## 🏗️ Structure

```
.
├── manifest.json          # Plugin manifest (required)
└── BarWidget.qml          # Bar icon widget (required)
```

### manifest.json

```jsonc
{
  "schemaVersion": 1,
  "id": "coddy-webapp",             // unique plugin identifier
  "name": "Coddy Web App",          // displayed name
  "version": "1.0.0",               // SemVer
  "author": "NeuralDeep",
  "description": "Launch Coddy in a standalone browser window",
  "homepage": "https://github.com/NeuralDeep/coddy-omarchy-webapp",
  "license": "MIT",
  "kinds": ["bar-widget"],
  "entryPoints": {
    "barWidget": "BarWidget.qml"
  },
  "barWidget": {
    "displayName": "Coddy",
    "category": "AI Tools",
    "allowMultiple": false,
    "defaultSection": "right"
  }
}
```

## 🐛 Troubleshooting

**Icon doesn't appear**

1. Check the plugin is enabled:
   ```bash
   omarchy plugin list
   ```
2. Check for QML errors:
   ```bash
   journalctl -f -q | grep -i "coddy\|qml.*warn\|qml.*error"
   ```
3. Restart the shell:
   ```bash
   kill -TERM $(pgrep -f quickshell)
   ```

**Coddy doesn't open**

1. Make sure Coddy is running on the configured port:
   ```bash
   curl -s http://127.0.0.1:12345/ > /dev/null && echo "OK" || echo "FAIL"
   ```
2. Try opening in default browser as a test:
   ```bash
   xdg-open http://127.0.0.1:12345/
   ```
3. Check that your browser supports app mode:
   ```bash
   chromium --version
   ```

**"Cannot read property 'Read' of undefined"**

This was a known bug in early versions caused by an incorrect
`Qt.access()` call. Update to the latest version of this plugin.

## 📝 Development

### Validate plugin

```bash
omarchy plugin validate ~/.config/omarchy/plugins/coddy-webapp
```

### Test changes without installing

1. Edit `~/.config/omarchy/plugins/coddy-webapp/BarWidget.qml`
2. Restart the shell:
   ```bash
   kill -TERM $(pgrep -f quickshell)
   ```
3. Changes are picked up automatically on the next shell start.

### Create your own plugin

```bash
# Clone a built-in Omarchy plugin as a starting point
omarchy plugin clone omarchy.network --edit

# Then modify the QML files
```

## 📄 License

[MIT](LICENSE)

## 🔗 See Also

- [Coddy](https://github.com/NeuralDeep/coddy) — AI coding assistant
- [Omarchy](https://github.com/neuraldeep/omarchy) — Arch Linux desktop environment
- [Quickshell](https://github.com/JFlaQuickshell/quickshell) — QML-based shell framework
