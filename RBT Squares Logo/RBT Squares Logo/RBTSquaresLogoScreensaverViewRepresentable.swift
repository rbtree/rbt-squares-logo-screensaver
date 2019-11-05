//
//  RBTSquaresLogoScreensaverViewRepresentable.swift
//  RBT Squares Logo
//
//  Created by Srdjan Markovic on 05/11/2019.
//  Copyright © 2019 Srđan Marković. All rights reserved.
//

import SwiftUI

struct RBTSquaresLogoScreensaverViewRepresentable: NSViewRepresentable {
    typealias NSViewType = RBTSquaresLogoScreenSaverView

    func makeNSView(context: NSViewRepresentableContext<RBTSquaresLogoScreensaverViewRepresentable>) -> RBTSquaresLogoScreenSaverView {
        
        // Return animated view
        let saver = RBTSquaresLogoScreenSaverView(frame: .zero, isPreview: true)!
        Timer.scheduledTimer(withTimeInterval: 1.0 / 30, repeats: true) { _ in
            saver.animateOneFrame()
        }
        return saver
    }
    
    func updateNSView(_ nsView: RBTSquaresLogoScreenSaverView, context: NSViewRepresentableContext<RBTSquaresLogoScreensaverViewRepresentable>) {
        // ...
    }
}
