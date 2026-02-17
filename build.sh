#!/bin/bash

# Build script for BrowserSelector
# This script builds the app using xcodebuild command line tools

set -e

echo "Building BrowserSelector..."

# Check if xcodebuild is available
if ! command -v xcodebuild &> /dev/null; then
    echo "Error: xcodebuild not found. Please install Xcode Command Line Tools."
    echo "Run: xcode-select --install"
    exit 1
fi

# Clean build directory
echo "Cleaning build directory..."
rm -rf build/

# Build the app
echo "Building app..."
xcodebuild \
    -project BrowserSelector.xcodeproj \
    -scheme BrowserSelector \
    -configuration Release \
    -derivedDataPath build \
    build

# Check if build was successful
if [ -d "build/Build/Products/Release/BrowserSelector.app" ]; then
    echo ""
    echo "✅ Build successful!"
    echo ""
    echo "The app is located at: build/Build/Products/Release/BrowserSelector.app"
    echo ""
    echo "To install, run:"
    echo "  cp -r build/Build/Products/Release/BrowserSelector.app /Applications/"
    echo ""
    echo "Then set it as your default browser in System Settings."
else
    echo "❌ Build failed"
    exit 1
fi
