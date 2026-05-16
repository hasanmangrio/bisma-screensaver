import ScreenSaver
import SwiftUI

final class BismaScreenSaverView: ScreenSaverView {
    private var hostingView: NSHostingView<BismaView>?
    private var configWindowController: ConfigSheetController?

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let bundle = Bundle(for: BismaScreenSaverView.self)
        FontLoader.loadPoppins(bundle: bundle)

        let defaults = UserDefaults(suiteName: "com.bisma.screensaver")
        let name = defaults?.string(forKey: "userName").flatMap { $0.isEmpty ? nil : $0 } ?? "Friend"
        let quote = QuoteManager(bundle: bundle).dailyQuote()
        let background = BackgroundManager(bundle: bundle).dailyBackground()

        let content = BismaView(name: name, quote: quote, backgroundImage: background)
        let hosting = NSHostingView(rootView: content)
        hosting.frame = bounds
        hosting.autoresizingMask = [.width, .height]
        addSubview(hosting)
        hostingView = hosting
    }

    override func animateOneFrame() {}

    override var hasConfigureSheet: Bool { true }

    override var configureSheet: NSWindow? {
        if configWindowController == nil {
            configWindowController = ConfigSheetController()
        }
        return configWindowController?.window
    }
}
