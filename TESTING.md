# Testing Guide

This guide provides instructions for testing the BrowserSelector app.

## Prerequisites

Before testing:
1. Build the app using Xcode or `./build.sh`
2. Install at least one supported browser (Chrome, Firefox, or Edge)
3. Copy the built app to `/Applications/`

## Test Cases

### 1. URL Handling Test

Test that the app correctly receives and displays URLs:

```bash
# Test with a simple URL
open "https://www.example.com" -a "/Applications/BrowserSelector.app"

# Test with a URL containing query parameters
open "https://github.com/sabajamalian/browser-selector?tab=readme" -a "/Applications/BrowserSelector.app"

# Test with a long URL
open "https://www.example.com/very/long/path/with/multiple/segments?param1=value1&param2=value2" -a "/Applications/BrowserSelector.app"

# Test with http (not https)
open "http://www.example.com" -a "/Applications/BrowserSelector.app"
```

**Expected Result**: A window should appear showing the URL and available browsers.

### 2. Browser Detection Test

**Test Steps:**
1. Open the app with any URL
2. Check the list of detected browsers

**Expected Results:**
- All installed browsers (Chrome, Firefox, Edge) should appear
- Each browser should show its name and installation path
- Browser icons should be displayed with appropriate colors

**Variations:**
- Test with only Chrome installed
- Test with only Firefox installed
- Test with only Edge installed
- Test with all three browsers installed
- Test with no browsers installed (should show "No supported browsers found")

### 3. Chrome Profile Detection Test

**Prerequisites:** Install Google Chrome with multiple profiles

**Test Steps:**
1. Create multiple Chrome profiles:
   - Open Chrome
   - Go to Chrome menu > Settings > Manage profiles
   - Add 2-3 different profiles with different names
2. Open the app with any URL
3. Select Chrome from the browser list

**Expected Results:**
- All Chrome profiles should be listed
- Profile names should match what's shown in Chrome
- "Default" profile should appear if it exists
- First profile should be auto-selected

### 4. URL Opening Test

Test that URLs open correctly in selected browsers:

**For Chrome:**
```bash
open "https://www.example.com" -a "/Applications/BrowserSelector.app"
# Select Chrome and a specific profile, click Open
# Expected: Chrome opens with the selected profile
```

**For Firefox:**
```bash
open "https://www.example.com" -a "/Applications/BrowserSelector.app"
# Select Firefox, click Open
# Expected: Firefox opens with the URL
```

**For Edge:**
```bash
open "https://www.example.com" -a "/Applications/BrowserSelector.app"
# Select Edge, click Open
# Expected: Edge opens with the URL
```

### 5. Default Browser Test

**Test Steps:**
1. Set BrowserSelector as default browser in System Settings
2. Click a link in Mail, Messages, or any other app
3. Verify the selector window appears

**Expected Results:**
- Window appears when any link is clicked
- URL from the clicked link is displayed
- Browser selection works correctly

### 6. UI Interaction Test

**Test keyboard shortcuts:**
- Press `Escape` → Window should close
- Press `Return/Enter` → Should open URL in selected browser
- Use Tab to navigate between browser options

**Test mouse interactions:**
- Click on different browsers → Selection should highlight
- Click on different Chrome profiles → Selection should highlight
- Click "Cancel" → Window should close
- Click "Open" → URL should open in selected browser

### 7. Auto-Selection Test

**Test Steps:**
1. Open the app with a URL
2. Do not click anything

**Expected Results:**
- First available browser should be auto-selected
- If Chrome is auto-selected, first profile should be auto-selected
- "Open" button should be enabled immediately

### 8. Error Handling Test

**Test with invalid browser path:**
1. Manually edit browser paths (for development/debugging)
2. Try to open a URL

**Expected Result:** Error message should appear if opening fails

### 9. Multi-Window Test

**Test Steps:**
1. Open a URL with the app
2. Before closing, open another URL
3. Check that only one window exists

**Expected Result:** Old window should close, new window should appear

### 10. Window Behavior Test

**Test Steps:**
1. Open the app window
2. Click on another app
3. Check window behavior

**Expected Results:**
- Window should remain visible (floating level)
- Window should be closable
- Window should not appear in Dock

## Performance Tests

### Browser Detection Speed
- Time how long it takes to detect browsers
- Should be near-instantaneous (< 100ms)

### Chrome Profile Detection Speed
- Time how long it takes to detect profiles
- Should be fast even with many profiles (< 500ms)

### Window Opening Speed
- Time from URL open to window display
- Should be very fast (< 200ms)

## Integration Tests

### Test with Different Apps

Test clicking links from:
- Mail.app
- Messages.app
- Slack
- VS Code
- Terminal
- Notes
- Safari
- Chrome

### Test with System Settings

1. Go to System Settings > Desktop & Dock
2. Change default browser to BrowserSelector
3. Change back to another browser
4. Change back to BrowserSelector
5. Verify it works each time

## Manual Verification Checklist

- [ ] App installs to /Applications correctly
- [ ] App appears in default browser list in System Settings
- [ ] URL handling works from all apps
- [ ] All installed browsers are detected
- [ ] Chrome profiles are detected correctly
- [ ] Browser selection works
- [ ] Profile selection works for Chrome
- [ ] "Open" button launches correct browser
- [ ] Window closes after opening URL
- [ ] "Cancel" button works
- [ ] Keyboard shortcuts work (Escape, Return)
- [ ] Error messages display when needed
- [ ] Auto-selection works on first launch
- [ ] Window doesn't appear in Dock
- [ ] Only one window appears at a time
- [ ] Long URLs display correctly (truncated)
- [ ] App doesn't crash with edge cases

## Automated Testing

Currently, there are no automated tests. Future improvements could include:
- Unit tests for BrowserDetector
- UI tests for ContentView interactions
- Integration tests for URL handling

## Reporting Issues

When reporting issues, include:
- macOS version
- Xcode version (if building)
- List of installed browsers and versions
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Console logs from Console.app (filter for "BrowserSelector")
