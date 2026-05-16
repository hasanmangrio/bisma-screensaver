SAVER_NAME  = BismaScreenSaver
BUILD_DIR   = build
BUNDLE      = $(BUILD_DIR)/$(SAVER_NAME).saver

SOURCES = Sources/BismaScreenSaverView.swift \
          Sources/BismaView.swift \
          Sources/QuoteManager.swift \
          Sources/BackgroundManager.swift \
          Sources/ConfigSheetController.swift \
          Sources/FontLoader.swift

SDK    = $(shell xcrun --show-sdk-path --sdk macosx)
ARCH   = $(shell uname -m)
TARGET = $(ARCH)-apple-macos13.0

SWIFTFLAGS = \
	-module-name $(SAVER_NAME) \
	-emit-library \
	-Xlinker -bundle \
	-sdk $(SDK) \
	-target $(TARGET) \
	-framework ScreenSaver \
	-framework Cocoa \
	-framework SwiftUI \
	-framework AppKit

.PHONY: all clean install uninstall

all: $(BUNDLE)

$(BUNDLE): $(SOURCES) Resources/Info.plist
	@mkdir -p $(BUNDLE)/Contents/MacOS
	@mkdir -p $(BUNDLE)/Contents/Resources/Backgrounds
	swiftc $(SOURCES) $(SWIFTFLAGS) -o $(BUNDLE)/Contents/MacOS/$(SAVER_NAME)
	@cp Resources/Info.plist $(BUNDLE)/Contents/
	@cp ../quotes.txt $(BUNDLE)/Contents/Resources/
	@cp ../ayahs.txt  $(BUNDLE)/Contents/Resources/
	@cp ../new-backgrounds/*.jpg $(BUNDLE)/Contents/Resources/Backgrounds/ 2>/dev/null || true
	@cp ../Poppins/Poppins-Thin.ttf \
	    ../Poppins/Poppins-ExtraLight.ttf \
	    ../Poppins/Poppins-Light.ttf \
	    ../Poppins/Poppins-LightItalic.ttf \
	    ../Poppins/Poppins-Regular.ttf \
	    ../Poppins/Poppins-Medium.ttf \
	    $(BUNDLE)/Contents/Resources/
	@xattr -cr $(BUNDLE)
	@codesign -s - $(BUNDLE)
	@echo ""
	@echo "✓ Built $(BUNDLE)"

install: all
	@rm -rf ~/Library/Screen\ Savers/$(SAVER_NAME).saver
	@cp -r $(BUNDLE) ~/Library/Screen\ Savers/
	@echo "✓ Installed to ~/Library/Screen Savers/$(SAVER_NAME).saver"
	@echo ""
	@echo "→ Open System Settings → Screen Saver → select 'Bisma'"
	@echo "→ Click 'Screen Saver Options…' to enter your name"

uninstall:
	@rm -rf ~/Library/Screen\ Savers/$(SAVER_NAME).saver
	@echo "✓ Uninstalled"

clean:
	@rm -rf $(BUILD_DIR)
	@echo "✓ Cleaned"
