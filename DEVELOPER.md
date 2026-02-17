# Developer Guide

## Project Structure

```
BrowserSelector/
├── BrowserSelector.xcodeproj/         # Xcode project file
├── BrowserSelector/                    # Source code directory
│   ├── BrowserSelectorApp.swift       # Main app entry point and URL handling
│   ├── ContentView.swift              # SwiftUI view for browser selection
│   ├── BrowserDetector.swift          # Browser and profile detection logic
│   ├── Info.plist                     # App configuration and URL scheme registration
│   └── Assets.xcassets/               # App assets and icons
├── build.sh                           # Build script for command-line builds
└── README.md                          # User documentation
```

## Architecture

### BrowserSelectorApp.swift
The main entry point of the application. Key features:
- Uses `@NSApplicationDelegateAdaptor` to integrate with AppDelegate
- AppDelegate handles URL opening events from the system
- Creates a floating window when a URL needs to be opened
- Sets the app as an accessory (no dock icon)

### ContentView.swift
The SwiftUI-based user interface. Components:
- **URL Display**: Shows the URL to be opened
- **Browser Selection**: Lists detected browsers with icons
- **Profile Selection**: Shows Chrome profiles (when Chrome is selected)
- **Action Buttons**: Cancel and Open buttons

UI State Management:
- `@StateObject` for BrowserDetector
- `@State` for selected browser and profile
- Dynamic UI updates based on selected browser

### BrowserDetector.swift
Core business logic for browser and profile detection:

**Browser Detection**:
- Uses `NSWorkspace.shared.urlForApplication(withBundleIdentifier:)` to find apps
- Fallback to common installation paths
- Supports: Chrome, Firefox, Edge

**Chrome Profile Detection**:
- Reads from `~/Library/Application Support/Google/Chrome/`
- Detects "Default" and "Profile N" directories
- Parses profile names from `Preferences` JSON file

**URL Opening**:
- Chrome: Direct executable launch with `--profile-directory` flag
- Firefox/Edge: Uses `open -a` command

### Info.plist
Critical configuration:
- `CFBundleURLTypes`: Registers as HTTP/HTTPS handler
- `LSUIElement`: Hides from dock
- Bundle identifier: `com.sabajamalian.BrowserSelector`

## How URL Handling Works

1. **User clicks a link** in any app (Mail, Slack, etc.)
2. **macOS routes the URL** to the registered default browser (BrowserSelector)
3. **AppDelegate receives** the URL via `application(_:open:)`
4. **Window is created** with ContentView showing the URL and options
5. **User selects** browser (and profile for Chrome)
6. **URL is opened** in the selected browser using appropriate method
7. **Window closes** automatically

## Browser Detection Logic

### Chrome
- Bundle ID: `com.google.Chrome`
- Common paths:
  - `/Applications/Google Chrome.app`
  - `~/Applications/Google Chrome.app`
- Profile detection from Chrome's preferences directory

### Firefox
- Bundle ID: `org.mozilla.firefox`
- Common paths:
  - `/Applications/Firefox.app`
  - `~/Applications/Firefox.app`

### Edge
- Bundle ID: `com.microsoft.edgemac`
- Common paths:
  - `/Applications/Microsoft Edge.app`
  - `~/Applications/Microsoft Edge.app`

## Chrome Profile Detection

Chrome profiles are stored in:
```
~/Library/Application Support/Google/Chrome/
├── Default/
│   └── Preferences
├── Profile 1/
│   └── Preferences
├── Profile 2/
│   └── Preferences
...
```

Each `Preferences` file is a JSON containing:
```json
{
  "profile": {
    "name": "User Display Name"
  }
}
```

## Building and Testing

### Using Xcode
1. Open `BrowserSelector.xcodeproj`
2. Select BrowserSelector scheme
3. Build (⌘B) and Run (⌘R)

### Using Command Line
```bash
./build.sh
```

### Testing URL Handling
After building, test with:
```bash
open "https://example.com" -a "/path/to/BrowserSelector.app"
```

## Registering as Default Browser

The app must be:
1. Located in `/Applications/` or `~/Applications/`
2. Properly code signed (for Gatekeeper)
3. Selected in System Settings > Desktop & Dock > Default web browser

## Code Signing

For development:
- Automatic signing is configured
- Set `DEVELOPMENT_TEAM` in project settings if needed

For distribution:
- Create a Developer ID Application certificate
- Enable hardened runtime
- Notarize the app with Apple

## Future Enhancements

Potential improvements:
- [ ] Remember last browser/profile choice per domain
- [ ] Add keyboard shortcuts for quick selection
- [ ] Support for more browsers (Brave, Safari, Opera)
- [ ] Profile detection for Firefox (multiple Firefox installations)
- [ ] Custom rules based on URL patterns
- [ ] Menu bar icon for quick settings
- [ ] Dark mode support
- [ ] Localization support

## Troubleshooting

### App doesn't appear in default browser list
- Ensure app is in `/Applications/`
- Check `Info.plist` has correct URL scheme registration
- Restart Mac and check again

### Browsers not detected
- Verify browsers are in standard installation paths
- Check bundle identifiers are correct
- Run detector logic manually to debug

### Chrome profiles not showing
- Verify Chrome profile directory exists
- Check permissions on Chrome profile folders
- Ensure `Preferences` file is valid JSON

## Testing Checklist

- [ ] App launches successfully
- [ ] URL opens the selection window
- [ ] All installed browsers are detected
- [ ] Chrome profiles are listed correctly
- [ ] Clicking "Open" launches the selected browser
- [ ] Profile selection works for Chrome
- [ ] Window closes after opening
- [ ] Cancel button works
- [ ] Keyboard shortcuts work (Escape, Return)
