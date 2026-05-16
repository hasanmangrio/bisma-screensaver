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
	@cat Resources/Info.plist > $(BUNDLE)/Contents/Info.plist
	@cat ../quotes.txt > $(BUNDLE)/Contents/Resources/quotes.txt
	@cat ../ayahs.txt  > $(BUNDLE)/Contents/Resources/ayahs.txt
	@for img in ../new-backgrounds/File_*.jpg; do \
	    cat "$$img" > "$(BUNDLE)/Contents/Resources/Backgrounds/$$(basename $$img)"; \
	done
	@cat ../Poppins/Poppins-Thin.ttf      > $(BUNDLE)/Contents/Resources/Poppins-Thin.ttf
	@cat ../Poppins/Poppins-ExtraLight.ttf > $(BUNDLE)/Contents/Resources/Poppins-ExtraLight.ttf
	@cat ../Poppins/Poppins-Light.ttf      > $(BUNDLE)/Contents/Resources/Poppins-Light.ttf
	@cat ../Poppins/Poppins-LightItalic.ttf > $(BUNDLE)/Contents/Resources/Poppins-LightItalic.ttf
	@cat ../Poppins/Poppins-Regular.ttf    > $(BUNDLE)/Contents/Resources/Poppins-Regular.ttf
	@cat ../Poppins/Poppins-Medium.ttf     > $(BUNDLE)/Contents/Resources/Poppins-Medium.ttf
	@codesign --remove-signature $(BUNDLE)/Contents/MacOS/$(SAVER_NAME) 2>/dev/null || true
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
