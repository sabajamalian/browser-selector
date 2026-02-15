# Deployment Guide

This guide explains how to build, sign, and distribute the BrowserSelector app.

## Building for Development

### Using Xcode

1. Open `BrowserSelector.xcodeproj` in Xcode
2. Select the BrowserSelector scheme
3. Build (⌘B) for development
4. The app will be in `~/Library/Developer/Xcode/DerivedData/`

### Using Command Line

```bash
./build.sh
```

The built app will be in `build/Build/Products/Release/BrowserSelector.app`

## Installing for Personal Use

```bash
# After building
cp -r build/Build/Products/Release/BrowserSelector.app /Applications/

# Or use the Finder to drag the app to Applications folder
```

## Code Signing

For the app to run on other Macs, it needs to be properly signed.

### Development Signing

Xcode handles this automatically if you have:
1. An Apple ID added in Xcode preferences
2. Automatic signing enabled in project settings

### Distribution Signing

For distributing to others:

1. **Join Apple Developer Program** ($99/year)
   - Required for distributing outside the Mac App Store
   - Provides Developer ID certificates

2. **Create a Developer ID Application Certificate**
   - Go to https://developer.apple.com/account/resources/certificates
   - Create new certificate → Developer ID Application
   - Download and install in Keychain

3. **Update Project Settings**
   - In Xcode, select the project
   - Go to Signing & Capabilities
   - Disable automatic signing
   - Select your Developer ID certificate

4. **Archive and Export**
   ```
   Product > Archive
   Distribute App > Developer ID
   ```

### Manual Code Signing

```bash
# Sign the app
codesign --force --deep --sign "Developer ID Application: Your Name (TEAM_ID)" \
  /Applications/BrowserSelector.app

# Verify signing
codesign -vvv --deep --strict /Applications/BrowserSelector.app
spctl -a -vvv /Applications/BrowserSelector.app
```

## Notarization

For distribution on macOS 10.15+, apps must be notarized by Apple.

### Notarization Process

1. **Create an App-Specific Password**
   - Go to https://appleid.apple.com
   - Sign in > Security > App-Specific Passwords
   - Generate a password for notarization

2. **Store Credentials**
   ```bash
   xcrun notarytool store-credentials "BrowserSelector-Profile" \
     --apple-id "your@email.com" \
     --team-id "YOUR_TEAM_ID" \
     --password "app-specific-password"
   ```

3. **Create Distribution Archive**
   ```bash
   # Create a zip of the signed app
   ditto -c -k --keepParent /Applications/BrowserSelector.app BrowserSelector.zip
   ```

4. **Submit for Notarization**
   ```bash
   xcrun notarytool submit BrowserSelector.zip \
     --keychain-profile "BrowserSelector-Profile" \
     --wait
   ```

5. **Staple the Notarization**
   ```bash
   xcrun stapler staple /Applications/BrowserSelector.app
   ```

6. **Verify**
   ```bash
   spctl -a -vvv -t install /Applications/BrowserSelector.app
   ```

## Distribution Methods

### 1. Direct Download

**Advantages:**
- Full control
- No fees (after Developer Program)
- Quick updates

**Steps:**
1. Sign and notarize the app
2. Create a DMG or ZIP file
3. Host on your website or GitHub Releases

**Creating a DMG:**
```bash
# Simple DMG creation
hdiutil create -volname "BrowserSelector" \
  -srcfolder /Applications/BrowserSelector.app \
  -ov -format UDZO BrowserSelector.dmg
```

### 2. GitHub Releases

1. Create a release on GitHub
2. Upload the notarized DMG/ZIP
3. Users download and install manually

### 3. Homebrew Cask

Create a cask formula for easy installation:

```ruby
cask "browser-selector" do
  version "1.0.0"
  sha256 "checksum_here"

  url "https://github.com/sabajamalian/browser-selector/releases/download/v#{version}/BrowserSelector.dmg"
  name "Browser Selector"
  desc "Choose which browser to open links with"
  homepage "https://github.com/sabajamalian/browser-selector"

  app "BrowserSelector.app"
end
```

### 4. Mac App Store (Optional)

**Advantages:**
- Built-in distribution
- Automatic updates
- Trusted by users

**Disadvantages:**
- Review process
- Sandboxing requirements
- 30% revenue share (if paid)

**Requirements:**
- Entitlements for app sandbox
- Hardened runtime enabled
- Compliance with App Store guidelines

## Updating the App

### Version Numbering

Update version in `BrowserSelector.xcodeproj`:
- `MARKETING_VERSION`: User-facing version (1.0, 1.1, etc.)
- `CURRENT_PROJECT_VERSION`: Build number (1, 2, 3, etc.)

### Automatic Updates

For apps distributed outside Mac App Store, consider:
- **Sparkle Framework**: Open-source update framework
  - https://sparkle-project.org/
  - Requires code signing
  - Automatic update checks

## Pre-Distribution Checklist

Before distributing:

- [ ] Test on clean Mac (no Xcode installed)
- [ ] Test on multiple macOS versions (13.0+)
- [ ] Verify all supported browsers work
- [ ] Verify Chrome profile detection works
- [ ] Check app icon displays correctly
- [ ] Verify code signing with `codesign -vvv`
- [ ] Verify notarization with `spctl -a -vvv`
- [ ] Test installation from DMG/ZIP
- [ ] Test setting as default browser
- [ ] Test URL opening from various apps
- [ ] Review Console.app for any errors
- [ ] Document known issues/limitations

## Distribution Package Contents

Your distribution should include:

```
BrowserSelector/
├── BrowserSelector.app          # The application
├── README.txt                   # Installation instructions
└── LICENSE.txt                  # MIT License
```

Sample README.txt:
```
Browser Selector - Installation Instructions

1. Drag BrowserSelector.app to your Applications folder
2. Open System Settings > Desktop & Dock
3. Set BrowserSelector as your default web browser
4. Click any link to choose which browser to use

For more information, visit:
https://github.com/sabajamalian/browser-selector

Supported Browsers: Chrome, Firefox, Edge
macOS Version: 13.0 or later
```

## Continuous Integration

For automated builds, use GitHub Actions:

```yaml
name: Build

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Build
      run: |
        xcodebuild -project BrowserSelector.xcodeproj \
          -scheme BrowserSelector \
          -configuration Release \
          build
    
    - name: Archive
      if: startsWith(github.ref, 'refs/tags/')
      run: |
        xcodebuild -project BrowserSelector.xcodeproj \
          -scheme BrowserSelector \
          -configuration Release \
          archive -archivePath build/BrowserSelector.xcarchive
```

## Troubleshooting

### "App is damaged and can't be opened"
- App is not notarized
- Run notarization process

### "Unidentified developer" warning
- App is not signed with Developer ID
- Users can bypass: Right-click > Open

### App doesn't appear in default browser list
- Must be in /Applications
- Must have CFBundleURLTypes in Info.plist
- Restart Mac after installation

## Support and Maintenance

After distribution:
- Monitor GitHub issues
- Provide updates for macOS changes
- Test with new browser versions
- Update documentation as needed
