import QtQuick
import Quickshell
import qs.Commons
import qs.Ui

/**
 * Coddy Web App — Omarchy shell plugin
 *
 * Adds a Coddy icon to the top bar. Clicking it launches Coddy's
 * web UI in a standalone Chrome/Chromium window (app mode – no
 * address bar, no tabs) via the Omarchy standard launcher.
 *
 * Settings (set via omarchy plugin settings):
 *   port  – Coddy listening port (default 12345)
 *   width – window width in app mode (default 0 = browser default)
 *   height – window height in app mode (default 0 = browser default)
 *
 * @see https://github.com/NeuralDeep/coddy-omarchy-webapp
 */

Item {
  id: root

  property QtObject bar: null
  property var settings: ({})

  /** Derived URL of the Coddy web interface */
  readonly property int coddyPort: Number(setting("port", 12345))
  readonly property string coddyUrl: "http://127.0.0.1:" + coddyPort + "/"

  /** Read a setting value, falling back to *fallback* if unset or null. */
  function setting(name, fallback) {
    var value = settings ? settings[name] : undefined
    return value === undefined || value === null ? fallback : value
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "\uE6A7"  // cod-icon glyph from the Omarchy icon font
    slotSize: Style.bar.statusSlot
    tooltipText: "Coddy"

    /**
     * Left-click — launch Coddy in a standalone Chrome window.
     * Middle-click — open in the system default browser (tab mode).
     */
    onPressed: function(btn) {
      if (btn === Qt.MiddleButton) {
        // middle-click: open in default browser
        Quickshell.execDetached(["xdg-open", root.coddyUrl])
      } else {
        // left-click: launch Chrom(e/ium) in app mode
        launchAppMode()
      }
    }
  }

  /**
   * Launch Coddy via the Omarchy standard launcher which resolves
   * the system's default web browser and starts it with --app=<url>.
   */
  function launchAppMode() {
    var args = ["omarchy-launch-webapp", root.coddyUrl]

    var w = Number(setting("width", 0))
    var h = Number(setting("height", 0))
    if (w > 0 && h > 0) {
      args = args.concat(["--app-window-size=" + w + "," + h])
    }

    Quickshell.execDetached(args)
  }
}
