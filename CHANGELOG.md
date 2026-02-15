# Changelog

All notable changes to BrowserSelector will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-15

### Added
- Initial release of BrowserSelector
- macOS application that can be set as default web browser
- Browser detection for Chrome, Firefox, and Edge
- Chrome profile detection and selection
- SwiftUI-based user interface
- URL scheme handler for http:// and https://
- Floating window for browser selection
- Auto-selection of first available browser and profile
- Error handling and user feedback
- Keyboard shortcuts (Escape to cancel, Enter to open)
- Build script for command-line builds
- Comprehensive documentation:
  - README.md - User guide
  - QUICKSTART.md - Quick start guide
  - DEVELOPER.md - Technical documentation
  - TESTING.md - Testing guide
  - DEPLOYMENT.md - Distribution guide
  - ICON.md - Icon generation instructions
- App icon design (SVG)
- GitHub Actions workflow for CI/CD

### Features
- Register as default browser on macOS 13.0+
- Automatically detect installed browsers
- Chrome profile support with profile name detection
- Clean, native macOS UI built with SwiftUI
- Runs as accessory app (no dock icon)
- Only one selection window at a time
- URL displayed before opening
- Visual browser selection with icons
- Profile selection for Chrome users

### Technical Details
- Built with Swift 5.0
- Uses SwiftUI for modern macOS UI
- Target: macOS 13.0 or later
- Xcode 15.0 or later for building
- Bundle ID: com.sabajamalian.BrowserSelector

### Known Limitations
- Only supports Chrome, Firefox, and Edge
- Chrome profile detection only works with standard profile locations
- No persistent settings or preferences
- No URL pattern rules or automatic routing
- No menu bar icon or system tray integration

## [Unreleased]

### Planned Features
- Remember last browser/profile choice per domain
- Custom rules based on URL patterns
- Support for more browsers (Brave, Safari, Opera, Vivaldi)
- Profile detection for Firefox
- Menu bar icon for settings
- Dark mode refinements
- Localization support
- Automatic updates via Sparkle framework
- Preferences window for configuration

### Possible Improvements
- URL pattern matching and rules
- Browser/profile favorites
- Keyboard shortcuts for quick browser selection (1-9)
- History of opened URLs
- Statistics and usage tracking
- Custom browser icons
- Theme customization
- Multiple window support
- AppleScript support
