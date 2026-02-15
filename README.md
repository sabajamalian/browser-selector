# Browser Selector

A macOS application that can be set as your default web browser. When you click a link, it opens a small window that lets you choose which browser (Chrome, Firefox, or Edge) to use. For Chrome, you can also select which profile to use.

## Features

- 🌐 Register as default browser on macOS
- 🔍 Automatically detect installed browsers (Chrome, Firefox, Edge)
- 👤 Chrome profile support - select which profile to use when opening links
- 🎨 Clean, native macOS UI built with SwiftUI
- ⚡ Fast and lightweight

## Quick Start

**New to BrowserSelector?** Check out the [Quick Start Guide](QUICKSTART.md) for a 5-minute setup!

## Documentation

- 📖 [Quick Start Guide](QUICKSTART.md) - Get started in 5 minutes
- 🛠️ [Developer Guide](DEVELOPER.md) - Technical architecture and development
- 🧪 [Testing Guide](TESTING.md) - Comprehensive testing procedures
- 🚀 [Deployment Guide](DEPLOYMENT.md) - Code signing and distribution
- 🎨 [Icon Guide](ICON.md) - App icon generation
- 🤝 [Contributing](CONTRIBUTING.md) - How to contribute
- 📋 [Changelog](CHANGELOG.md) - Version history and roadmap

## Requirements

- macOS 13.0 or later
- Xcode 15.0 or later (for building)
- At least one supported browser installed (Chrome, Firefox, or Edge)

## Building the App

1. Clone this repository:
   ```bash
   git clone https://github.com/sabajamalian/browser-selector.git
   cd browser-selector
   ```

2. Open the project in Xcode:
   ```bash
   open BrowserSelector.xcodeproj
   ```

3. Build and run the project:
   - Select "BrowserSelector" scheme
   - Click the Run button or press ⌘R

4. Archive the app for distribution:
   - In Xcode, select Product > Archive
   - Once archived, select "Distribute App" > "Copy App"
   - Move the generated `.app` file to your Applications folder

## Setting as Default Browser

1. Open System Settings (System Preferences on older macOS versions)
2. Go to "Desktop & Dock" (or "General" on older macOS versions)
3. Find "Default web browser" dropdown
4. Select "BrowserSelector" from the list

Note: The app must be in your Applications folder to appear in the list.

## How It Works

1. When a link is clicked from any application, macOS routes the URL to BrowserSelector
2. BrowserSelector opens a small window displaying:
   - The URL to be opened
   - Available browsers installed on your system
   - Chrome profiles (if Chrome is selected)
3. Select your preferred browser (and profile for Chrome)
4. Click "Open" to launch the URL in your chosen browser

## Supported Browsers

- **Google Chrome** - with profile selection support
- **Mozilla Firefox**
- **Microsoft Edge**

## Troubleshooting

### App doesn't appear in the default browser list
- Make sure the app is installed in `/Applications/` or `~/Applications/`
- Restart your Mac after installation
- Check that Info.plist has the correct URL scheme configuration

### No browsers detected
- Ensure you have Chrome, Firefox, or Edge installed in `/Applications/`
- The app looks for browsers using their bundle identifiers
- Check browser installation paths in the app logs

### Chrome profiles not showing
- Open Chrome and verify your profiles exist (Chrome menu > Profile)
- Check that Chrome profile directories exist at:
  `~/Library/Application Support/Google/Chrome/`
- Each profile should have a `Preferences` file

### URL doesn't open
- Verify the selected browser is properly installed
- Check that the browser has permission to open
- Try selecting a different browser

## License

MIT License - see [LICENSE](LICENSE) file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 
