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

    // MARK: - Lifecycle
    override func draw(_ rect: NSRect) {
        // Draw a single frame in this function
        super.draw(rect)
        
        NSColor.white.setFill()
        rect.fill()
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
