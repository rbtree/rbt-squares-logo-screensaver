//
//  RBTSquaresLogoScreensaverView.swift
//  RBT Squares Logo
//
//  Created by Srdjan Markovic on 05/11/2019.
//  Copyright © 2019 Srđan Marković. All rights reserved.
//

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

    func drawLogo(frame targetFrame: NSRect = NSRect(x: 0, y: 0, width: 1024, height: 1024), resizing: ResizingBehavior = .aspectFit) {
        
        // General Declarations
        let context = NSGraphicsContext.current!.cgContext
        
        // Resize to Target Frame
        NSGraphicsContext.saveGraphicsState()
        let resizedFrame: NSRect = resizing.apply(rect: NSRect(x: 0, y: 0, width: 1024, height: 1024), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 1024, y: resizedFrame.height / 1024)

        // rbt-squares-logo
        NSGraphicsContext.saveGraphicsState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)

        // rbt-squares-sign
        
//        // rbt-squares-white
//        rbtwhite.setFill()
//
//        let white20Path = NSRect(x: 512, y: 192, width: 64, height: 64)
//        white20Path.fill()
//
//        let white19Path = NSRect(x: 512, y: 256, width: 64, height: 64)
//        white19Path.fill()
//
//        let white17Path = NSRect(x: 768, y: 384, width: 64, height: 64)
//        white17Path.fill()
//
//        let white18Path = NSRect(x: 512, y: 320, width: 64, height: 64)
//        white18Path.fill()
//
//        let white16Path = NSRect(x: 640, y: 384, width: 64, height: 64)
//        white16Path.fill()
//
//        let white15Path = NSRect(x: 704, y: 448, width: 64, height: 64)
//        white15Path.fill()
//
//        let white14Path = NSRect(x: 384, y: 448, width: 64, height: 64)
//        white14Path.fill()
//
//        let white13Path = NSRect(x: 704, y: 512, width: 64, height: 64)
//        white13Path.fill()
//
//        let white12Path = NSRect(x: 576, y: 512, width: 64, height: 64)
//        white12Path.fill()
//
//        let white11Path = NSRect(x: 384, y: 512, width: 64, height: 64)
//        white11Path.fill()
//
//        let white10Path = NSRect(x: 256, y: 512, width: 64, height: 64)
//        white10Path.fill()
//
//        let white09Path = NSRect(x: 768, y: 576, width: 64, height: 64)
//        white09Path.fill()
//
//        let white08Path = NSRect(x: 448, y: 576, width: 64, height: 64)
//        white08Path.fill()
//
//        let white07Path = NSRect(x: 704, y: 640, width: 64, height: 64)
//        white07Path.fill()
//
//        let white06Path = NSRect(x: 576, y: 640, width: 64, height: 64)
//        white06Path.fill()
//
//        let white05Path = NSRect(x: 320, y: 640, width: 64, height: 64)
//        white05Path.fill()
//
//        let white04Path = NSRect(x: 640, y: 704, width: 64, height: 64)
//        white04Path.fill()
//
//        let white03Path = NSRect(x: 384, y: 704, width: 64, height: 64)
//        white03Path.fill()
//
//        let white02Path = NSRect(x: 576, y: 768, width: 64, height: 64)
//        white02Path.fill()
//
//        let white01Path = NSRect(x: 448, y: 768, width: 64, height: 64)
//        white01Path.fill()
//
//        // rbt-squares-black
//        rbtblack.setFill()
//
//        let black40Path = NSRect(x: 448, y: 192, width: 64, height: 64)
//        black40Path.fill()
//
//        let black39Path = NSRect(x: 448, y: 256, width: 64, height: 64)
//        black39Path.fill()
//
//        let black38Path = NSRect(x: 448, y: 320, width: 64, height: 64)
//        black38Path.fill()
//
//        let black37Path = NSRect(x: 704, y: 384, width: 64, height: 64)
//        black37Path.fill()
//
//        let black36Path = NSRect(x: 576, y: 384, width: 64, height: 64)
//        black36Path.fill()
//
//        let black35Path = NSRect(x: 512, y: 384, width: 64, height: 64)
//        black35Path.fill()
//
//        let black34Path = NSRect(x: 448, y: 384, width: 64, height: 64)
//        black34Path.fill()
//
//        let black33Path = NSRect(x: 384, y: 384, width: 64, height: 64)
//        black33Path.fill()
//
//        let black32Path = NSRect(x: 320, y: 384, width: 64, height: 64)
//        black32Path.fill()
//
//        let black31Path = NSRect(x: 640, y: 448, width: 64, height: 64)
//        black31Path.fill()
//
//        let black30Path = NSRect(x: 576, y: 448, width: 64, height: 64)
//        black30Path.fill()
//
//        let black29Path = NSRect(x: 512, y: 448, width: 64, height: 64)
//        black29Path.fill()
//
//        let black28Path = NSRect(x: 448, y: 448, width: 64, height: 64)
//        black28Path.fill()
//
//        let black27Path = NSRect(x: 320, y: 448, width: 64, height: 64)
//        black27Path.fill()
//
//        let black26Path = NSRect(x: 256, y: 448, width: 64, height: 64)
//        black26Path.fill()
//
//        let black25Path = NSRect(x: 640, y: 512, width: 64, height: 64)
//        black25Path.fill()
//
//        let black24Path = NSRect(x: 512, y: 512, width: 64, height: 64)
//        black24Path.fill()
//
//        let black23Path = NSRect(x: 448, y: 512, width: 64, height: 64)
//        black23Path.fill()
//
//        let black22Path = NSRect(x: 320, y: 512, width: 64, height: 64)
//        black22Path.fill()
//
//        let black21Path = NSRect(x: 192, y: 512, width: 64, height: 64)
//        black21Path.fill()
//
//        let black20Path = NSRect(x: 704, y: 576, width: 64, height: 64)
//        black20Path.fill()
//
//        let black19Path = NSRect(x: 640, y: 576, width: 64, height: 64)
//        black19Path.fill()
//
//        let black18Path = NSRect(x: 576, y: 576, width: 64, height: 64)
//        black18Path.fill()
//
//        let black17Path = NSRect(x: 512, y: 576, width: 64, height: 64)
//        black17Path.fill()
//
//        let black16Path = NSRect(x: 384, y: 576, width: 64, height: 64)
//        black16Path.fill()
//
//        let black15Path = NSRect(x: 320, y: 576, width: 64, height: 64)
//        black15Path.fill()
//
//        let black14Path = NSRect(x: 256, y: 576, width: 64, height: 64)
//        black14Path.fill()
//
//        let black13Path = NSRect(x: 640, y: 640, width: 64, height: 64)
//        black13Path.fill()
//
//        let black12Path = NSRect(x: 512, y: 640, width: 64, height: 64)
//        black12Path.fill()
//
//        let black11Path = NSRect(x: 448, y: 640, width: 64, height: 64)
//        black11Path.fill()
//
//        let black10Path = NSRect(x: 384, y: 640, width: 64, height: 64)
//        black10Path.fill()
//
//        let black09Path = NSRect(x: 256, y: 640, width: 64, height: 64)
//        black09Path.fill()
//
//        let black08Path = NSRect(x: 192, y: 640, width: 64, height: 64)
//        black08Path.fill()
//
//        let black07Path = NSRect(x: 576, y: 704, width: 64, height: 64)
//        black07Path.fill()
//
//        let black06Path = NSRect(x: 512, y: 704, width: 64, height: 64)
//        black06Path.fill()
//
//        let black05Path = NSRect(x: 448, y: 704, width: 64, height: 64)
//        black05Path.fill()
//
//        let black04Path = NSRect(x: 320, y: 704, width: 64, height: 64)
//        black04Path.fill()
//
//        let black03Path = NSRect(x: 256, y: 704, width: 64, height: 64)
//        black03Path.fill()
//
//        let black02Path = NSRect(x: 512, y: 768, width: 64, height: 64)
//        black02Path.fill()
//
//        let black01Path = NSRect(x: 384, y: 768, width: 64, height: 64)
//        black01Path.fill()
//
//        // rbt-squares-red
//        rbtred.setFill()
//
//        let red54Path = NSRect(x: 768, y: 128, width: 64, height: 64)
//        red54Path.fill()
//
//        let red53Path = NSRect(x: 704, y: 128, width: 64, height: 64)
//        red53Path.fill()
//
//        let red52Path = NSRect(x: 640, y: 128, width: 64, height: 64)
//        red52Path.fill()
//
//        let red50Path = NSRect(x: 576, y: 128, width: 64, height: 64)
//        red50Path.fill()
//
//        let red49Path = NSRect(x: 768, y: 192, width: 64, height: 64)
//        red49Path.fill()
//
//        let red48Path = NSRect(x: 704, y: 192, width: 64, height: 64)
//        red48Path.fill()
//
//        let red47Path = NSRect(x: 640, y: 192, width: 64, height: 64)
//        red47Path.fill()
//
//        let red46Path = NSRect(x: 576, y: 192, width: 64, height: 64)
//        red46Path.fill()
//
//        let red45Path = NSRect(x: 384, y: 192, width: 64, height: 64)
//        red45Path.fill()
//
//        let red44Path = NSRect(x: 320, y: 192, width: 64, height: 64)
//        red44Path.fill()
//
//        let red43Path = NSRect(x: 256, y: 192, width: 64, height: 64)
//        red43Path.fill()
//
//        let red42Path = NSRect(x: 192, y: 192, width: 64, height: 64)
//        red42Path.fill()
//
//        let red41Path = NSRect(x: 128, y: 192, width: 64, height: 64)
//        red41Path.fill()
//
//        let red40Path = NSRect(x: 768, y: 256, width: 64, height: 64)
//        red40Path.fill()
//
//        let red39Path = NSRect(x: 704, y: 256, width: 64, height: 64)
//        red39Path.fill()
//
//        let red38Path = NSRect(x: 640, y: 256, width: 64, height: 64)
//        red38Path.fill()
//
//        let red37Path = NSRect(x: 576, y: 256, width: 64, height: 64)
//        red37Path.fill()
//
//        let red36Path = NSRect(x: 384, y: 256, width: 64, height: 64)
//        red36Path.fill()
//
//        let red35Path = NSRect(x: 320, y: 256, width: 64, height: 64)
//        red35Path.fill()
//
//        let red34Path = NSRect(x: 256, y: 256, width: 64, height: 64)
//        red34Path.fill()
//
//        let red33Path = NSRect(x: 192, y: 256, width: 64, height: 64)
//        red33Path.fill()
//
//        let red32Path = NSRect(x: 128, y: 256, width: 64, height: 64)
//        red32Path.fill()
//
//        let red31Path = NSRect(x: 768, y: 320, width: 64, height: 64)
//        red31Path.fill()
//
//        let red30Path = NSRect(x: 704, y: 320, width: 64, height: 64)
//        red30Path.fill()
//
//        let red29Path = NSRect(x: 640, y: 320, width: 64, height: 64)
//        red29Path.fill()
//
//        let red28Path = NSRect(x: 576, y: 320, width: 64, height: 64)
//        red28Path.fill()
//
//        let red27Path = NSRect(x: 384, y: 320, width: 64, height: 64)
//        red27Path.fill()
//
//        let red26Path = NSRect(x: 320, y: 320, width: 64, height: 64)
//        red26Path.fill()
//
//        let red25Path = NSRect(x: 256, y: 320, width: 64, height: 64)
//        red25Path.fill()
//
//        let red24Path = NSRect(x: 192, y: 320, width: 64, height: 64)
//        red24Path.fill()
//
//        let red23Path = NSRect(x: 128, y: 320, width: 64, height: 64)
//        red23Path.fill()
//
//        let red22Path = NSRect(x: 256, y: 384, width: 64, height: 64)
//        red22Path.fill()
//
//        let red21Path = NSRect(x: 192, y: 384, width: 64, height: 64)
//        red21Path.fill()
//
//        let red20Path = NSRect(x: 128, y: 384, width: 64, height: 64)
//        red20Path.fill()
//
//        let red19Path = NSRect(x: 832, y: 448, width: 64, height: 64)
//        red19Path.fill()
//
//        let red18Path = NSRect(x: 768, y: 448, width: 64, height: 64)
//        red18Path.fill()
//
//        let red17Path = NSRect(x: 192, y: 448, width: 64, height: 64)
//        red17Path.fill()
//
//        let red16Path = NSRect(x: 128, y: 448, width: 64, height: 64)
//        red16Path.fill()
//
//        let red15Path = NSRect(x: 832, y: 512, width: 64, height: 64)
//        red15Path.fill()
//
//        let red14Path = NSRect(x: 768, y: 512, width: 64, height: 64)
//        red14Path.fill()
//
//        let red13Path = NSRect(x: 768, y: 640, width: 64, height: 64)
//        red13Path.fill()
//
//        let red12Path = NSRect(x: 768, y: 704, width: 64, height: 64)
//        red12Path.fill()
//
//        let red11Path = NSRect(x: 704, y: 704, width: 64, height: 64)
//        red11Path.fill()
//
//        let red10Path = NSRect(x: 192, y: 704, width: 64, height: 64)
//        red10Path.fill()
//
//        let red09Path = NSRect(x: 768, y: 768, width: 64, height: 64)
//        red09Path.fill()
//
//        let red08Path = NSRect(x: 704, y: 768, width: 64, height: 64)
//        red08Path.fill()
//
//        let red07Path = NSRect(x: 640, y: 768, width: 64, height: 64)
//        red07Path.fill()
//
//        let red06Path = NSRect(x: 320, y: 768, width: 64, height: 64)
//        red06Path.fill()
//
//        let red05Path = NSRect(x: 256, y: 768, width: 64, height: 64)
//        red05Path.fill()
//
//        let red04Path = NSRect(x: 192, y: 768, width: 64, height: 64)
//        red04Path.fill()
//
//        let red03Path = NSRect(x: 320, y: 832, width: 64, height: 64)
//        red03Path.fill()
//
//        let red02Path = NSRect(x: 256, y: 832, width: 64, height: 64)
//        red02Path.fill()
//
//        let red01Path = NSRect(x: 192, y: 832, width: 64, height: 64)
//        red01Path.fill()

        rbtwhite.setFill()
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
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        
        let r = CGRect(x: rect.midX - 512/2, y: rect.midY - 512/2, width: 512, height: 512)
        
        drawLogo(frame: r, resizing: .aspectFit)
    }
    
    override func startAnimation() {
        super.startAnimation()
    }

    override func animateOneFrame() {
        super.animateOneFrame()
    }

    override func stopAnimation() {
        super.stopAnimation()
    }
}
