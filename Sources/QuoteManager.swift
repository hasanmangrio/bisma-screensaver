import Foundation

struct QuoteManager {
    private let quotes: [Quote]

    init(bundle: Bundle) {
        var loaded: [Quote] = []
        for name in ["quotes", "ayahs"] {
            guard let url = bundle.url(forResource: name, withExtension: "txt"),
                  let content = try? String(contentsOf: url, encoding: .utf8)
            else { continue }

            for line in content.components(separatedBy: .newlines) {
                let trimmed = line.trimmingCharacters(in: .whitespaces)
                guard !trimmed.isEmpty else { continue }
                let parts = trimmed.components(separatedBy: "::")
                guard parts.count >= 2 else { continue }
                let text = parts[0].trimmingCharacters(in: .init(charactersIn: "\"' "))
                let author = parts[1].trimmingCharacters(in: .init(charactersIn: "\"' "))
                guard !text.isEmpty, !author.isEmpty else { continue }
                loaded.append(Quote(text: text, author: author))
            }
        }
        quotes = loaded
    }

    func dailyQuote() -> Quote {
        guard !quotes.isEmpty else {
            return Quote(text: "Indeed, with hardship [will be] ease.", author: "Quran 94:6")
        }
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        return quotes[dayOfYear % quotes.count]
    }
}
