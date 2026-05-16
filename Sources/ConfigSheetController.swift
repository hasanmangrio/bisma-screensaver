import AppKit

final class ConfigSheetController: NSWindowController {
    private let defaults = UserDefaults(suiteName: "com.bisma.screensaver") ?? .standard
    private var nameField: NSTextField!

    convenience init() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 420, height: 140),
            styleMask: [.titled],
            backing: .buffered,
            defer: false
        )
        window.title = "Bisma Screen Saver"
        self.init(window: window)
        buildUI()
    }

    private func buildUI() {
        guard let content = window?.contentView else { return }

        let label = NSTextField(labelWithString: "Your Name")
        label.frame = NSRect(x: 24, y: 90, width: 80, height: 20)
        label.font = .systemFont(ofSize: 13)
        content.addSubview(label)

        nameField = NSTextField()
        nameField.frame = NSRect(x: 112, y: 87, width: 284, height: 24)
        nameField.placeholderString = "e.g. Hasan"
        nameField.stringValue = defaults.string(forKey: "userName") ?? ""
        nameField.font = .systemFont(ofSize: 13)
        content.addSubview(nameField)

        let ok = NSButton(title: "OK", target: self, action: #selector(save))
        ok.frame = NSRect(x: 324, y: 16, width: 72, height: 32)
        ok.bezelStyle = .rounded
        ok.keyEquivalent = "\r"
        content.addSubview(ok)

        let cancel = NSButton(title: "Cancel", target: self, action: #selector(cancel))
        cancel.frame = NSRect(x: 240, y: 16, width: 72, height: 32)
        cancel.bezelStyle = .rounded
        cancel.keyEquivalent = "\u{1b}"
        content.addSubview(cancel)
    }

    @objc private func save() {
        defaults.set(nameField.stringValue, forKey: "userName")
        dismissSheet()
    }

    @objc private func cancel() {
        dismissSheet()
    }

    private func dismissSheet() {
        guard let sheet = window else { return }
        sheet.sheetParent?.endSheet(sheet)
        sheet.orderOut(nil)
    }
}
