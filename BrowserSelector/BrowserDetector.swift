import Foundation
import AppKit

enum BrowserType: String, CaseIterable {
    case chrome = "Chrome"
    case firefox = "Firefox"
    case edge = "Edge"
    
    var bundleIdentifier: String {
        switch self {
        case .chrome:
            return "com.google.Chrome"
        case .firefox:
            return "org.mozilla.firefox"
        case .edge:
            return "com.microsoft.edgemac"
        }
    }
    
    var executableName: String {
        switch self {
        case .chrome:
            return "Google Chrome"
        case .firefox:
            return "Firefox"
        case .edge:
            return "Microsoft Edge"
        }
    }
}

struct Browser: Identifiable {
    let id = UUID()
    let name: String
    let path: String
    let type: BrowserType
}

struct ChromeProfile: Identifiable {
    let id = UUID()
    let name: String
    let directory: String
}

class BrowserDetector: ObservableObject {
    @Published var browsers: [Browser] = []
    @Published var chromeProfiles: [ChromeProfile] = []
    
    func detectBrowsers() {
        var detectedBrowsers: [Browser] = []
        
        for browserType in BrowserType.allCases {
            if let path = findBrowserPath(for: browserType) {
                let browser = Browser(
                    name: browserType.rawValue,
                    path: path,
                    type: browserType
                )
                detectedBrowsers.append(browser)
            }
        }
        
        DispatchQueue.main.async {
            self.browsers = detectedBrowsers
        }
    }
    
    func detectChromeProfiles() {
        var profiles: [ChromeProfile] = []
        
        let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
        let chromeDirectory = homeDirectory
            .appendingPathComponent("Library")
            .appendingPathComponent("Application Support")
            .appendingPathComponent("Google")
            .appendingPathComponent("Chrome")
        
        // Check for Default profile
        let defaultProfilePath = chromeDirectory.appendingPathComponent("Default")
        if FileManager.default.fileExists(atPath: defaultProfilePath.path) {
            let profileName = getProfileName(from: defaultProfilePath) ?? "Default"
            profiles.append(ChromeProfile(name: profileName, directory: "Default"))
        }
        
        // Check for numbered profiles (Profile 1, Profile 2, etc.)
        do {
            let contents = try FileManager.default.contentsOfDirectory(
                at: chromeDirectory,
                includingPropertiesForKeys: nil,
                options: [.skipsHiddenFiles]
            )
            
            for item in contents {
                let itemName = item.lastPathComponent
                if itemName.starts(with: "Profile ") {
                    let profileName = getProfileName(from: item) ?? itemName
                    profiles.append(ChromeProfile(name: profileName, directory: itemName))
                }
            }
        } catch {
            print("Error reading Chrome profile directories: \(error)")
        }
        
        DispatchQueue.main.async {
            self.chromeProfiles = profiles
        }
    }
    
    private func getProfileName(from profilePath: URL) -> String? {
        let prefsPath = profilePath.appendingPathComponent("Preferences")
        
        guard let data = try? Data(contentsOf: prefsPath),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let profile = json["profile"] as? [String: Any],
              let name = profile["name"] as? String else {
            return nil
        }
        
        return name
    }
    
    private func findBrowserPath(for browserType: BrowserType) -> String? {
        // Try to find the app using Spotlight
        let workspace = NSWorkspace.shared
        if let appURL = workspace.urlForApplication(withBundleIdentifier: browserType.bundleIdentifier) {
            return appURL.path
        }
        
        // Fallback: Check common installation paths
        let commonPaths = [
            "/Applications/\(browserType.executableName).app",
            "~/Applications/\(browserType.executableName).app"
        ]
        
        for path in commonPaths {
            let expandedPath = NSString(string: path).expandingTildeInPath
            if FileManager.default.fileExists(atPath: expandedPath) {
                return expandedPath
            }
        }
        
        return nil
    }
    
    func openURL(_ url: URL, withBrowser browser: Browser, profile: ChromeProfile? = nil) -> Bool {
        let process = Process()
        
        switch browser.type {
        case .chrome:
            // For Chrome, use the executable path inside the app bundle
            let executablePath = (browser.path as NSString)
                .appendingPathComponent("Contents/MacOS/Google Chrome")
            process.executableURL = URL(fileURLWithPath: executablePath)
            
            var arguments = [url.absoluteString]
            
            if let profile = profile {
                arguments.insert(contentsOf: [
                    "--profile-directory=\(profile.directory)"
                ], at: 0)
            }
            
            process.arguments = arguments
            
        case .firefox:
            // For Firefox, use the open command
            process.executableURL = URL(fileURLWithPath: "/usr/bin/open")
            process.arguments = [
                "-a", browser.path,
                url.absoluteString
            ]
            
        case .edge:
            // For Edge, use the open command
            process.executableURL = URL(fileURLWithPath: "/usr/bin/open")
            process.arguments = [
                "-a", browser.path,
                url.absoluteString
            ]
        }
        
        do {
            try process.run()
            return true
        } catch {
            print("Error opening URL: \(error)")
            return false
        }
    }
}
