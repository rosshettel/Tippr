// Renders the 1024×1024 app icon, then resize it for web/icons/:
//   swift scripts/make-icon.swift /tmp/icon.png
//   sips -s format png -z 180 180 /tmp/icon.png --out web/icons/apple-touch-icon.png
//   sips -s format png -z 192 192 /tmp/icon.png --out web/icons/icon-192.png
//   sips -s format png -z 512 512 /tmp/icon.png --out web/icons/icon-512.png
import CoreGraphics
import CoreText
import Foundation
import ImageIO
import UniformTypeIdentifiers

let size = 1024
let out = CommandLine.arguments.dropFirst().first ?? "AppIcon.png"

func rgb(_ hex: UInt32) -> CGColor {
    CGColor(srgbRed: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 8) & 0xff) / 255,
            blue: CGFloat(hex & 0xff) / 255, alpha: 1)
}

// Opaque context: App Store icons can't have alpha.
let ctx = CGContext(data: nil, width: size, height: size, bitsPerComponent: 8, bytesPerRow: 0,
                    space: CGColorSpace(name: CGColorSpace.sRGB)!,
                    bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)!

// Background: near-black with a faint lift toward the top.
let gradient = CGGradient(colorsSpace: nil, colors: [rgb(0x1c1c1f), rgb(0x0a0a0b)] as CFArray, locations: [0, 1])!
ctx.drawLinearGradient(gradient, start: CGPoint(x: 0, y: CGFloat(size)), end: .zero, options: [])

// A light-weight "$" in the orange accent, matching the yen-to-usd icon.
let font = CTFontCreateUIFontForLanguage(.system, 720, nil)!
let light = CTFontCreateCopyWithAttributes(font, 720, nil,
    CTFontDescriptorCreateWithAttributes([kCTFontTraitsAttribute: [kCTFontWeightTrait: -0.4]] as CFDictionary))
let text = NSAttributedString(string: "$", attributes: [
    kCTFontAttributeName as NSAttributedString.Key: light,
    kCTForegroundColorAttributeName as NSAttributedString.Key: rgb(0xff6a3d),
])

let line = CTLineCreateWithAttributedString(text)
let bounds = CTLineGetBoundsWithOptions(line, .useGlyphPathBounds)
ctx.textPosition = CGPoint(x: (CGFloat(size) - bounds.width) / 2 - bounds.minX,
                           y: (CGFloat(size) - bounds.height) / 2 - bounds.minY)
CTLineDraw(line, ctx)

let dest = CGImageDestinationCreateWithURL(URL(fileURLWithPath: out) as CFURL, UTType.png.identifier as CFString, 1, nil)!
CGImageDestinationAddImage(dest, ctx.makeImage()!, nil)
CGImageDestinationFinalize(dest)
print("wrote \(out)")
