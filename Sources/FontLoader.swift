import CoreText
import Foundation

enum FontLoader {
    static func loadPoppins(bundle: Bundle) {
        let names = [
            "Poppins-Thin",
            "Poppins-ExtraLight",
            "Poppins-Light",
            "Poppins-LightItalic",
            "Poppins-Regular",
            "Poppins-Medium",
        ]
        for name in names {
            guard let url = bundle.url(forResource: name, withExtension: "ttf") else { continue }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}
