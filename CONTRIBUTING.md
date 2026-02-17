# Contributing to BrowserSelector

Thank you for your interest in contributing to BrowserSelector! This document provides guidelines and information for contributors.

## Code of Conduct

Be respectful, constructive, and professional in all interactions.

## How to Contribute

### Reporting Bugs

If you find a bug:

1. Check if it's already reported in [GitHub Issues](https://github.com/sabajamalian/browser-selector/issues)
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - macOS version
   - List of installed browsers
   - Screenshots if applicable
   - Console logs if available

### Suggesting Features

For feature requests:

1. Check existing issues for similar requests
2. Create a new issue with:
   - Clear description of the feature
   - Use case and benefits
   - Possible implementation approach
   - Any relevant examples or mockups

### Pull Requests

We welcome pull requests! Here's the process:

1. **Fork the repository**
2. **Create a branch** (`git checkout -b feature/amazing-feature`)
3. **Make your changes**
4. **Test thoroughly** (see TESTING.md)
5. **Commit with clear messages**
6. **Push to your fork**
7. **Open a Pull Request**

## Development Setup

### Prerequisites

- macOS 13.0 or later
- Xcode 15.0 or later
- At least one browser installed for testing

### Getting Started

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/browser-selector.git
cd browser-selector

# Open in Xcode
open BrowserSelector.xcodeproj

# Build and run
# Press ⌘R in Xcode
```

### Project Structure

```
BrowserSelector/
├── BrowserSelector/
│   ├── BrowserSelectorApp.swift    # Main app entry point
│   ├── ContentView.swift           # UI implementation
│   ├── BrowserDetector.swift       # Business logic
│   └── Info.plist                  # App configuration
└── BrowserSelector.xcodeproj/      # Xcode project
```

## Coding Guidelines

### Swift Style

- Follow Swift API Design Guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions focused and small
- Use SwiftUI best practices

### Code Organization

- Keep view code in ContentView.swift
- Keep business logic in BrowserDetector.swift
- Separate concerns appropriately
- Add new files for new features

### Example

```swift
// Good: Clear, descriptive name
func detectInstalledBrowsers() -> [Browser] {
    // Implementation
}

// Bad: Unclear abbreviation
func detectBrs() -> [Browser] {
    // Implementation
}
```

## Testing

Before submitting a PR:

1. **Build successfully** in Xcode
2. **Test all features**:
   - Browser detection
   - Profile detection
   - URL opening
   - UI interactions
3. **Test on clean system** if possible
4. **Check console for errors**

See [TESTING.md](TESTING.md) for comprehensive testing guide.

## Commit Messages

Use clear, descriptive commit messages:

```
# Good
Add support for Brave browser detection

# Bad
Update code
```

Format:
```
<type>: <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build process or auxiliary tool changes

## Areas for Contribution

### Easy (Good First Issues)

- Add support for more browsers
- Improve error messages
- Add more keyboard shortcuts
- Enhance UI with animations
- Add more tests

### Medium

- Implement preferences storage
- Add URL pattern matching
- Create menu bar icon
- Add browser favorites
- Implement dark mode themes

### Advanced

- Automatic updates framework
- AppleScript support
- Browser profile detection for Firefox
- Deep linking support
- Plugin architecture

## Questions?

- Check [DEVELOPER.md](DEVELOPER.md) for technical details
- Ask in GitHub Issues
- Review existing code for patterns

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors will be acknowledged in:
- GitHub contributors list
- CHANGELOG.md for significant contributions
- README.md for major features

Thank you for contributing! 🎉
