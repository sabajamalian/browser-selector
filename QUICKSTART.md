# Quick Start Guide

Get started with BrowserSelector in 5 minutes!

## What is BrowserSelector?

BrowserSelector is a Mac app that lets you choose which browser to use every time you click a link. Perfect if you use multiple browsers or Chrome profiles for different purposes (work, personal, etc.).

## Installation

### Step 1: Build the App

**Option A: Using Xcode** (Recommended)
```bash
open BrowserSelector.xcodeproj
# Press ⌘R to build and run
# The app will open (nothing visible - it runs in the background)
```

**Option B: Using Command Line**
```bash
./build.sh
```

### Step 2: Install to Applications

```bash
# If you built with Xcode:
cp -r ~/Library/Developer/Xcode/DerivedData/BrowserSelector-*/Build/Products/Release/BrowserSelector.app /Applications/

# If you used build.sh:
cp -r build/Build/Products/Release/BrowserSelector.app /Applications/
```

### Step 3: Set as Default Browser

1. Open **System Settings** (or System Preferences on older macOS)
2. Go to **Desktop & Dock** (or General on older macOS)
3. Find **Default web browser** dropdown
4. Select **BrowserSelector**

**Note:** If BrowserSelector doesn't appear in the list, make sure it's in your Applications folder and restart your Mac.

## First Use

1. **Click any link** in Mail, Slack, Messages, or any other app
2. **A window appears** showing:
   - The URL you clicked
   - Available browsers (Chrome, Firefox, Edge)
   - Chrome profiles (if you have Chrome)
3. **Select your browser** by clicking on it
4. **Select a Chrome profile** (if using Chrome)
5. **Click "Open"** or press Enter

That's it! The URL opens in your chosen browser.

## Tips

- Press **Escape** to cancel and close the window
- Press **Enter** to quickly open with the selected browser
- The **first browser** is automatically selected for you
- For Chrome, the **first profile** is automatically selected
- Only **one window** appears at a time

## Supported Browsers

- ✅ **Google Chrome** (with profile selection)
- ✅ **Mozilla Firefox**
- ✅ **Microsoft Edge**

Make sure at least one of these browsers is installed!

## Troubleshooting

### BrowserSelector doesn't appear in default browser list
- Make sure it's in `/Applications/` folder
- Restart your Mac

### No browsers detected
- Install Chrome, Firefox, or Edge
- Make sure they're in the `/Applications/` folder

### Chrome profiles not showing
- Open Chrome and go to Settings → Manage profiles
- Make sure you have profiles created

### Link doesn't open
- Make sure the browser you selected is properly installed
- Try selecting a different browser
- Check Console.app for error messages

## Need Help?

- Read the full [README.md](README.md) for detailed information
- Check [TESTING.md](TESTING.md) for testing procedures
- See [DEVELOPER.md](DEVELOPER.md) for technical details
- Visit [GitHub Issues](https://github.com/sabajamalian/browser-selector/issues) to report bugs

## Uninstalling

1. Change default browser back to Safari (or another browser) in System Settings
2. Delete `/Applications/BrowserSelector.app`

That's all! No other files or folders are created.

---

**Enjoy choosing your browser!** 🎉
