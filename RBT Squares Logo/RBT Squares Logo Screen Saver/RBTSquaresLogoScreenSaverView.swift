//
//  RBTSquaresLogoScreensaverView.swift
//  RBT Squares Logo
//
//  Created by Srdjan Markovic on 05/11/2019.
//  Copyright © 2019 Srđan Marković. All rights reserved.
//

import Foundation
import ScreenSaver

/**
 Call Order
 When macOS starts your screen saver, the following things happen:
 1. The screen fades to black.
 2. Your module is instantiated and its `init(frame:isPreview:)` routine is called.
 3. The window is created.
 4. Your module is installed in the window.
 5. Your window is activated and its order is set. The `draw(_:)` call is called at this point.
 Note
 You should draw your initial state in the drawRect call. This initial state will be visible during the fade in that follows.
 6. The screen fades in, revealing your window in the front.
 7. Your `startAnimation()` method is called. This method should not do any drawing.
 Note
 If you override this method, be sure to call the method in your superclass.
 8. Drawing continues. Your `animateOneFrame()` is called repeatedly.
 9. The user takes some action.
 10. Your `stopAnimation()` method is called.
 Note
 If you override this method, be sure to call the method in your superclass.
 Note
 The `stopAnimation()` or `startAnimation()` methods do not immediately start or stop animation. In particular, it is not safe to assume that your `animateOneFrame()` method will not execute (or continue to execute) after you call `stopAnimation()`.
 Do not attempt to use `stopAnimation()` to gate against animation occurring while you modify preferences or other state variables. It is not a mutex.

 More info at https://developer.apple.com/documentation/screensaver
 */
class RBTSquaresLogoScreenSaverView: ScreenSaverView {

    // MARK: - Initialization
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
    }

    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Cache

    private struct Cache {
        static let rbtwhite: NSColor = NSColor(red: 1, green: 1, blue: 1, alpha: 1)
        static let rbtblack: NSColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
        static let rbtred: NSColor = NSColor(red: 210 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1)
        static let whites: [NSRect] = [
            NSRect(x: 512, y: 192, width: 64, height: 64),
            NSRect(x: 512, y: 256, width: 64, height: 64),
            NSRect(x: 768, y: 384, width: 64, height: 64),
            NSRect(x: 512, y: 320, width: 64, height: 64),
            NSRect(x: 640, y: 384, width: 64, height: 64),
            NSRect(x: 704, y: 448, width: 64, height: 64),
            NSRect(x: 384, y: 448, width: 64, height: 64),
            NSRect(x: 704, y: 512, width: 64, height: 64),
            NSRect(x: 576, y: 512, width: 64, height: 64),
            NSRect(x: 384, y: 512, width: 64, height: 64),
            NSRect(x: 256, y: 512, width: 64, height: 64),
            NSRect(x: 768, y: 576, width: 64, height: 64),
            NSRect(x: 448, y: 576, width: 64, height: 64),
            NSRect(x: 704, y: 640, width: 64, height: 64),
            NSRect(x: 576, y: 640, width: 64, height: 64),
            NSRect(x: 320, y: 640, width: 64, height: 64),
            NSRect(x: 640, y: 704, width: 64, height: 64),
            NSRect(x: 384, y: 704, width: 64, height: 64),
            NSRect(x: 576, y: 768, width: 64, height: 64),
            NSRect(x: 448, y: 768, width: 64, height: 64)
        ]
        static let blacks: [NSRect] = [
            NSRect(x: 448, y: 192, width: 64, height: 64),
            NSRect(x: 448, y: 256, width: 64, height: 64),
            NSRect(x: 448, y: 320, width: 64, height: 64),
            NSRect(x: 704, y: 384, width: 64, height: 64),
            NSRect(x: 576, y: 384, width: 64, height: 64),
            NSRect(x: 512, y: 384, width: 64, height: 64),
            NSRect(x: 448, y: 384, width: 64, height: 64),
            NSRect(x: 384, y: 384, width: 64, height: 64),
            NSRect(x: 320, y: 384, width: 64, height: 64),
            NSRect(x: 640, y: 448, width: 64, height: 64),
            NSRect(x: 576, y: 448, width: 64, height: 64),
            NSRect(x: 512, y: 448, width: 64, height: 64),
            NSRect(x: 448, y: 448, width: 64, height: 64),
            NSRect(x: 320, y: 448, width: 64, height: 64),
            NSRect(x: 256, y: 448, width: 64, height: 64),
            NSRect(x: 640, y: 512, width: 64, height: 64),
            NSRect(x: 512, y: 512, width: 64, height: 64),
            NSRect(x: 448, y: 512, width: 64, height: 64),
            NSRect(x: 320, y: 512, width: 64, height: 64),
            NSRect(x: 192, y: 512, width: 64, height: 64),
            NSRect(x: 704, y: 576, width: 64, height: 64),
            NSRect(x: 640, y: 576, width: 64, height: 64),
            NSRect(x: 576, y: 576, width: 64, height: 64),
            NSRect(x: 512, y: 576, width: 64, height: 64),
            NSRect(x: 384, y: 576, width: 64, height: 64),
            NSRect(x: 320, y: 576, width: 64, height: 64),
            NSRect(x: 256, y: 576, width: 64, height: 64),
            NSRect(x: 640, y: 640, width: 64, height: 64),
            NSRect(x: 512, y: 640, width: 64, height: 64),
            NSRect(x: 448, y: 640, width: 64, height: 64),
            NSRect(x: 384, y: 640, width: 64, height: 64),
            NSRect(x: 256, y: 640, width: 64, height: 64),
            NSRect(x: 192, y: 640, width: 64, height: 64),
            NSRect(x: 576, y: 704, width: 64, height: 64),
            NSRect(x: 512, y: 704, width: 64, height: 64),
            NSRect(x: 448, y: 704, width: 64, height: 64),
            NSRect(x: 320, y: 704, width: 64, height: 64),
            NSRect(x: 256, y: 704, width: 64, height: 64),
            NSRect(x: 512, y: 768, width: 64, height: 64),
            NSRect(x: 384, y: 768, width: 64, height: 64)
        ]
        static let reds: [NSRect] = [
            NSRect(x: 768, y: 128, width: 64, height: 64),
            NSRect(x: 704, y: 128, width: 64, height: 64),
            NSRect(x: 640, y: 128, width: 64, height: 64),
            NSRect(x: 576, y: 128, width: 64, height: 64),
            NSRect(x: 768, y: 192, width: 64, height: 64),
            NSRect(x: 704, y: 192, width: 64, height: 64),
            NSRect(x: 640, y: 192, width: 64, height: 64),
            NSRect(x: 576, y: 192, width: 64, height: 64),
            NSRect(x: 384, y: 192, width: 64, height: 64),
            NSRect(x: 320, y: 192, width: 64, height: 64),
            NSRect(x: 256, y: 192, width: 64, height: 64),
            NSRect(x: 192, y: 192, width: 64, height: 64),
            NSRect(x: 128, y: 192, width: 64, height: 64),
            NSRect(x: 768, y: 256, width: 64, height: 64),
            NSRect(x: 704, y: 256, width: 64, height: 64),
            NSRect(x: 640, y: 256, width: 64, height: 64),
            NSRect(x: 576, y: 256, width: 64, height: 64),
            NSRect(x: 384, y: 256, width: 64, height: 64),
            NSRect(x: 320, y: 256, width: 64, height: 64),
            NSRect(x: 256, y: 256, width: 64, height: 64),
            NSRect(x: 192, y: 256, width: 64, height: 64),
            NSRect(x: 128, y: 256, width: 64, height: 64),
            NSRect(x: 768, y: 320, width: 64, height: 64),
            NSRect(x: 704, y: 320, width: 64, height: 64),
            NSRect(x: 640, y: 320, width: 64, height: 64),
            NSRect(x: 576, y: 320, width: 64, height: 64),
            NSRect(x: 384, y: 320, width: 64, height: 64),
            NSRect(x: 320, y: 320, width: 64, height: 64),
            NSRect(x: 256, y: 320, width: 64, height: 64),
            NSRect(x: 192, y: 320, width: 64, height: 64),
            NSRect(x: 128, y: 320, width: 64, height: 64),
            NSRect(x: 256, y: 384, width: 64, height: 64),
            NSRect(x: 192, y: 384, width: 64, height: 64),
            NSRect(x: 128, y: 384, width: 64, height: 64),
            NSRect(x: 832, y: 448, width: 64, height: 64),
            NSRect(x: 768, y: 448, width: 64, height: 64),
            NSRect(x: 192, y: 448, width: 64, height: 64),
            NSRect(x: 128, y: 448, width: 64, height: 64),
            NSRect(x: 832, y: 512, width: 64, height: 64),
            NSRect(x: 768, y: 512, width: 64, height: 64),
            NSRect(x: 768, y: 640, width: 64, height: 64),
            NSRect(x: 768, y: 704, width: 64, height: 64),
            NSRect(x: 704, y: 704, width: 64, height: 64),
            NSRect(x: 192, y: 704, width: 64, height: 64),
            NSRect(x: 768, y: 768, width: 64, height: 64),
            NSRect(x: 704, y: 768, width: 64, height: 64),
            NSRect(x: 640, y: 768, width: 64, height: 64),
            NSRect(x: 320, y: 768, width: 64, height: 64),
            NSRect(x: 256, y: 768, width: 64, height: 64),
            NSRect(x: 192, y: 768, width: 64, height: 64),
            NSRect(x: 320, y: 832, width: 64, height: 64),
            NSRect(x: 256, y: 832, width: 64, height: 64),
            NSRect(x: 192, y: 832, width: 64, height: 64)
        ]
    }

    // MARK: - Colors

    var rbtwhite: NSColor { return Cache.rbtwhite }
    var rbtblack: NSColor { return Cache.rbtblack }
    var rbtred: NSColor { return Cache.rbtred }

    var whites: [NSRect] { return Cache.whites }
    var blacks: [NSRect] { return Cache.blacks }
    var reds: [NSRect] { return Cache.reds }

    // MARK: - Drawing Methods

    func drawBackground(color: NSColor = .clear) {
        let background = NSBezierPath(rect: bounds)
        color.setFill()
        background.fill()
    }

    func drawLogo(_ rect: NSRect = NSRect(x: 0, y: 0, width: 1024, height: 1024), resizing: ResizingBehavior = .aspectFit) {
        
        // General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        // Resize to Target Frame
        NSGraphicsContext.saveGraphicsState()
        let resizedFrame: NSRect = resizing.apply(rect: NSRect(x: 0, y: 0, width: 1024, height: 1024), target: rect)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 1024, y: resizedFrame.height / 1024)

        // rbt-squares-logo
        NSGraphicsContext.saveGraphicsState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)

        // rbt-squares-sign
        
        rbtwhite.setFill()
        // TODO: make union and single fill for all squares instead of filling separately!
        whites.forEach { rect in
            rect.fill()
        }
        rbtblack.setFill()
        blacks.forEach { rect in
            rect.fill()
        }
        rbtred.setFill()
        reds.forEach { rect in
            rect.fill()
        }

        context.endTransparencyLayer()
        NSGraphicsContext.restoreGraphicsState()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
    @objc(RBTSquaresLogoResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: NSRect, target: NSRect) -> NSRect {
            if rect == target || target == NSRect.zero {
                return rect
            }

            var scales = NSSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }

    // MARK: - Lifecycle
    
    override func layout() {
        super.layout()
        
        center = CGPoint(x: frame.midX, y: frame.midY)
    }
        
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        
        drawBackground(color: .darkGray)

        let r = CGRect(x: center.x - size / 2, y: center.y - size / 2, width: size, height: size)
        // rbtwhite.withAlphaComponent(0.01).setFill()
        // r.fill()
        drawLogo(r, resizing: .aspectFit)
    }
    
    override func startAnimation() {
        guard isPreview else {
            return
        }
        
        super.startAnimation()
    }

    override func animateOneFrame() {
        guard isPreview else {
            return
        }
        
        super.animateOneFrame()
        
        let oob = isOutOfBounds()
        if oob.x {
            velocity.dx *= -1
        }
        if oob.y {
            velocity.dy *= -1
        }
        center.x += velocity.dx
        center.y += velocity.dy

        setNeedsDisplay(bounds)
    }

    override func stopAnimation() {
        guard isPreview else {
            return
        }
        
        super.stopAnimation()
    }
    
    // MARK: - Private variables
    
    let size: CGFloat = 512
    var center: CGPoint = .zero
    var velocity: CGVector = {
        let desiredVelocityMagnitude: CGFloat = 2
        let xVelocity = CGFloat.random(in: 0.5...1.5)
        let xSign: CGFloat = Bool.random() ? 1 : -1
        let yVelocity = sqrt(pow(desiredVelocityMagnitude, 2) - pow(xVelocity, 2))
        let ySign: CGFloat = Bool.random() ? 1 : -1
        return CGVector(dx: xVelocity * xSign, dy: yVelocity * ySign)
    }()
    
    // MARK: - Private utility functions
    
    private func isOutOfBounds() -> (x: Bool, y: Bool) {
        let x = center.x - size / 2 <= 0 || center.x + size / 2 >= bounds.width
        let y = center.y - size / 2 <= 0 || center.y + size / 2 >= bounds.height
        return (x, y)
    }
}
