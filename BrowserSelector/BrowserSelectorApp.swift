import SwiftUI

@main
struct BrowserSelectorApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide from dock
        NSApp.setActivationPolicy(.accessory)
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        // Handle URL opening
        guard let url = urls.first else { return }
        showBrowserSelector(for: url)
    }
    
    private func showBrowserSelector(for url: URL) {
        // Close existing window if any
        window?.close()
        
        // Create and show the browser selection window
        let contentView = ContentView(url: url, closeWindow: { [weak self] in
            self?.window?.close()
            self?.window = nil
        })
        
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 450, height: 400),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.title = "Browser Selector"
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        window.level = .floating
        
        NSApp.activate(ignoringOtherApps: true)
        
        self.window = window
    }
}
