# App Icon Generation

This document explains how to generate the app icon for BrowserSelector.

## Icon Design

The icon (`icon.svg`) represents:
- Three browser windows (Chrome in red, Firefox in orange, Edge in blue)
- A downward arrow indicating selection
- "BS" text for Browser Selector

## Generating Icon Assets

To generate the required icon sizes for macOS:

### Using iconutil (macOS built-in)

1. First, convert the SVG to PNG at various sizes. You can use any image editor or command-line tools:

```bash
# Using ImageMagick (if installed)
for size in 16 32 128 256 512; do
  magick icon.svg -resize ${size}x${size} icon_${size}x${size}.png
  magick icon.svg -resize $((size*2))x$((size*2)) icon_${size}x${size}@2x.png
done
```

2. Create an iconset folder:

```bash
mkdir BrowserSelector.iconset
```

3. Copy the PNG files with the correct naming:

```bash
cp icon_16x16.png BrowserSelector.iconset/icon_16x16.png
cp icon_16x16@2x.png BrowserSelector.iconset/icon_16x16@2x.png
cp icon_32x32.png BrowserSelector.iconset/icon_32x32.png
cp icon_32x32@2x.png BrowserSelector.iconset/icon_32x32@2x.png
cp icon_128x128.png BrowserSelector.iconset/icon_128x128.png
cp icon_128x128@2x.png BrowserSelector.iconset/icon_128x128@2x.png
cp icon_256x256.png BrowserSelector.iconset/icon_256x256.png
cp icon_256x256@2x.png BrowserSelector.iconset/icon_256x256@2x.png
cp icon_512x512.png BrowserSelector.iconset/icon_512x512.png
cp icon_512x512@2x.png BrowserSelector.iconset/icon_512x512@2x.png
```

4. Convert to icns:

```bash
iconutil -c icns BrowserSelector.iconset
```

5. Replace the AppIcon in Xcode:
   - Open `BrowserSelector/Assets.xcassets/AppIcon.appiconset/`
   - Drag and drop the generated PNG files into Xcode's AppIcon slots

### Using Online Tools

Alternatively, use online icon generators:
- https://cloudconvert.com/svg-to-icns
- https://iconverticons.com/online/

Upload `icon.svg` and download the generated .icns file, then add it to the Xcode project.

### Manual Xcode Method

1. Open the project in Xcode
2. Navigate to BrowserSelector > Assets.xcassets > AppIcon
3. Drag and drop PNG files of the following sizes into the appropriate slots:
   - 16x16, 32x32, 128x128, 256x256, 512x512
   - Include @2x versions (32x32, 64x64, 256x256, 512x512, 1024x1024)

## Current Setup

Currently, the project has placeholder AppIcon configuration. The actual icon images need to be added to make the app icon visible in Finder and the Applications folder.

For development and testing, the app will work without a custom icon (it will show the default app icon).
