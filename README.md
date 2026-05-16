# Bisma Screen Saver

A macOS screen saver that greets you with *Assalamu Alaikum*, your name, and a daily Islamic quote — set against a rotating collection of curated background photos.

Built with Swift + SwiftUI + ScreenSaver.framework. Uses the Poppins typeface throughout.

## Features

- Daily rotating background from a curated photo collection
- Personalised greeting: *Assalamu Alaikum, [Your Name]*
- Daily rotating quote from Quran ayahs and Islamic scholars
- Poppins typography with Apple-esque clean layout

## Requirements

- macOS 13 Ventura or later
- Xcode Command Line Tools (`xcode-select --install`)

## Build & Install

```bash
make install
```

This compiles the Swift sources, bundles the fonts, backgrounds, and quote files, signs the bundle ad-hoc, and copies it to `~/Library/Screen Savers/`.

Then:
1. Open **System Settings → Screen Saver**
2. Scroll to **Other** and select **Bisma**

## Set Your Name

```bash
defaults write com.bisma.screensaver userName "Your Name"
```

## Project Structure

```
Sources/
  BismaScreenSaverView.swift   # ScreenSaverView subclass — entry point
  BismaView.swift              # SwiftUI layout (greeting + quote)
  QuoteManager.swift           # Parses quote files, picks daily quote
  BackgroundManager.swift      # Loads background images, rotates daily
  FontLoader.swift             # Registers Poppins fonts at runtime
  ConfigSheetController.swift  # "Options…" settings sheet
Resources/
  Info.plist                   # Bundle config (NSPrincipalClass)
Makefile                       # make / make install / make clean
```

## Companion Chrome Extension

[Bisma](https://github.com/humzam/bisma) — the original new-tab extension this screen saver is based on.
