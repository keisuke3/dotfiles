import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    func application(_ application: NSApplication, open urls: [URL]) {
        guard let url = urls.first else {
            NSApp.terminate(nil)
            return
        }
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/bin/bash")
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        task.arguments = [
            home + "/.local/bin/open-in-wezterm.sh",
            url.path
        ]
        try? task.run()
        task.waitUntilExit()
        NSApp.terminate(nil)
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Launched without files - quit after short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            NSApp.terminate(nil)
        }
    }
}

let delegate = AppDelegate()
NSApplication.shared.delegate = delegate
NSApp.run()
