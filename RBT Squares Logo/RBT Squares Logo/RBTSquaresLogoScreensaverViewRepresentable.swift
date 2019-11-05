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
        return RBTSquaresLogoScreenSaverView()
    }
    
    func updateNSView(_ nsView: RBTSquaresLogoScreenSaverView, context: NSViewRepresentableContext<RBTSquaresLogoScreensaverViewRepresentable>) {
        // ...
    }
}
