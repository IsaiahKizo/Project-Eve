// ============================================================
// PROJECT-EVE — LcarsLabel
// ============================================================
// Styled text. Instead of restyling Text everywhere, use this one component
// so all labels share the same look and the theme stays in LcarsStyle.
//
// Example:   LcarsLabel { text: "HELLO"; ink: LcarsStyle.orange }
// ============================================================
import QtQuick

// We START FROM Qt's built-in "Text" item, then add convenience inputs on top.
Text {
    // Public inputs, with theme-based defaults:
    property color ink: LcarsStyle.fg              // text color
    property int size: LcarsStyle.fontSizeMedium   // font size (px)
    property int spacing: 3                        // extra space between letters

    // Apply the inputs. These are BINDINGS ("keep equal forever"), and notice
    // we can read our own properties ("ink", "size") as well as LcarsStyle.
    color: ink
    font.family: LcarsStyle.fontFamily   // which font to use (from the theme)
    font.pixelSize: size                 // font size in pixels
    font.bold: true                      // bold weight
    font.letterSpacing: spacing          // spacing between characters
    verticalAlignment: Text.AlignVCenter // keep text centered vertically (useful in rows)
}
