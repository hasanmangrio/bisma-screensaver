import SwiftUI
import AppKit

struct Quote: Sendable {
    let text: String
    let author: String
}

struct BismaView: View {
    let name: String
    let quote: Quote
    let backgroundImage: NSImage?

    var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundLayer
                vignetteLayer
                contentBlock
                    .frame(width: geo.size.width)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.44)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: – Layers

    @ViewBuilder
    private var backgroundLayer: some View {
        if let image = backgroundImage {
            Image(nsImage: image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
        } else {
            Color(red: 0.06, green: 0.08, blue: 0.12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var vignetteLayer: some View {
        ZStack {
            // Gentle overall darkening so backgrounds don't blow out the text
            Color.black.opacity(0.22)
            // Radial vignette — darkens edges, keeps center bright
            RadialGradient(
                colors: [.clear, .black.opacity(0.55)],
                center: .center,
                startRadius: 260,
                endRadius: 820
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: – Content

    private var contentBlock: some View {
        VStack(spacing: 0) {
            salutationLabel
                .padding(.bottom, 10)

            nameLabel

            divider
                .padding(.vertical, 36)

            quoteText
                .padding(.bottom, 22)

            authorText
        }
        .padding(.horizontal, 80)
    }

    private var salutationLabel: some View {
        Text("Assalamu Alaikum,")
            .font(.custom("Poppins-Light", size: 15))
            .tracking(3.5)
            .textCase(.uppercase)
            .foregroundColor(.white.opacity(0.55))
    }

    private var nameLabel: some View {
        Text(name)
            .font(.custom("Poppins-Thin", size: 68))
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.45), radius: 24, y: 8)
    }

    private var divider: some View {
        Rectangle()
            .fill(Color.white.opacity(0.22))
            .frame(width: 44, height: 0.75)
    }

    private var quoteText: some View {
        Text("\u{201C}\(quote.text)\u{201D}")
            .font(.custom("Poppins-Light", size: 17))
            .foregroundColor(.white.opacity(0.72))
            .multilineTextAlignment(.center)
            .lineSpacing(8)
            .tracking(0.3)
            .frame(maxWidth: 620)
            .shadow(color: .black.opacity(0.4), radius: 10)
    }

    private var authorText: some View {
        Text("— \(quote.author)")
            .font(.custom("Poppins-ExtraLight", size: 12))
            .foregroundColor(.white.opacity(0.42))
            .tracking(2.0)
    }
}
