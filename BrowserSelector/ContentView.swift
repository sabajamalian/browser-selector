import SwiftUI

struct ContentView: View {
    let url: URL
    let closeWindow: () -> Void
    
    @StateObject private var detector = BrowserDetector()
    @State private var selectedBrowser: Browser?
    @State private var selectedProfile: ChromeProfile?
    
    var body: some View {
        VStack(spacing: 20) {
            // URL Display
            VStack(alignment: .leading, spacing: 8) {
                Text("Open URL:")
                    .font(.headline)
                
                Text(url.absoluteString)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            
            // Browser Selection
            VStack(alignment: .leading, spacing: 12) {
                Text("Select Browser:")
                    .font(.headline)
                    .padding(.horizontal)
                
                if detector.browsers.isEmpty {
                    Text("No supported browsers found")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(detector.browsers) { browser in
                                BrowserButton(
                                    browser: browser,
                                    isSelected: selectedBrowser?.id == browser.id,
                                    action: {
                                        selectedBrowser = browser
                                        if browser.type != .chrome {
                                            selectedProfile = nil
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            // Chrome Profile Selection
            if selectedBrowser?.type == .chrome {
                Divider()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Select Chrome Profile:")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if detector.chromeProfiles.isEmpty {
                        Text("No Chrome profiles found")
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 8) {
                                ForEach(detector.chromeProfiles) { profile in
                                    ProfileButton(
                                        profile: profile,
                                        isSelected: selectedProfile?.id == profile.id,
                                        action: {
                                            selectedProfile = profile
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            
            Divider()
            
            // Action Buttons
            HStack {
                Button("Cancel") {
                    closeWindow()
                }
                .keyboardShortcut(.cancelAction)
                
                Spacer()
                
                Button("Open") {
                    openURL()
                }
                .keyboardShortcut(.defaultAction)
                .disabled(selectedBrowser == nil || (selectedBrowser?.type == .chrome && selectedProfile == nil))
            }
            .padding()
        }
        .frame(width: 450, height: 400)
        .onAppear {
            detector.detectBrowsers()
            detector.detectChromeProfiles()
        }
    }
    
    private func openURL() {
        guard let browser = selectedBrowser else { return }
        
        let success: Bool
        if browser.type == .chrome, let profile = selectedProfile {
            success = detector.openURL(url, withBrowser: browser, profile: profile)
        } else {
            success = detector.openURL(url, withBrowser: browser)
        }
        
        if success {
            closeWindow()
        }
    }
}

struct BrowserButton: View {
    let browser: Browser
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: browserIcon(for: browser.type))
                    .font(.title2)
                    .foregroundColor(browserColor(for: browser.type))
                
                VStack(alignment: .leading) {
                    Text(browser.name)
                        .font(.headline)
                    Text(browser.path)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
            .background(isSelected ? Color.accentColor.opacity(0.1) : Color.gray.opacity(0.05))
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
    
    private func browserIcon(for type: BrowserType) -> String {
        switch type {
        case .chrome:
            return "circle.fill"
        case .firefox:
            return "flame.fill"
        case .edge:
            return "e.circle.fill"
        }
    }
    
    private func browserColor(for type: BrowserType) -> Color {
        switch type {
        case .chrome:
            return .red
        case .firefox:
            return .orange
        case .edge:
            return .blue
        }
    }
}

struct ProfileButton: View {
    let profile: ChromeProfile
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.title3)
                    .foregroundColor(.blue)
                
                Text(profile.name)
                    .font(.body)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
            .background(isSelected ? Color.accentColor.opacity(0.1) : Color.gray.opacity(0.05))
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}
