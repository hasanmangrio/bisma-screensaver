import AppKit
import Foundation

struct BackgroundManager {
    private let imageURLs: [URL]

    init(bundle: Bundle) {
        guard let resourceURL = bundle.resourceURL else {
            imageURLs = []
            return
        }
        let backgroundsDir = resourceURL.appendingPathComponent("Backgrounds")
        let fm = FileManager.default
        let contents = (try? fm.contentsOfDirectory(at: backgroundsDir, includingPropertiesForKeys: nil)) ?? []
        imageURLs = contents
            .filter { ["jpg", "jpeg", "png"].contains($0.pathExtension.lowercased()) }
            .sorted { $0.lastPathComponent.localizedStandardCompare($1.lastPathComponent) == .orderedAscending }
    }

    func dailyBackground() -> NSImage? {
        guard !imageURLs.isEmpty else { return nil }
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        return NSImage(contentsOf: imageURLs[dayOfYear % imageURLs.count])
    }
}
