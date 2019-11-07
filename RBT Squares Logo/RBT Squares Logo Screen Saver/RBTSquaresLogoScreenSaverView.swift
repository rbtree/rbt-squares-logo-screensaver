//
//  RBTSquaresLogoScreensaverView.swift
//  RBT Squares Logo
//
//  Created by Srdjan Markovic on 05/11/2019.
//  Copyright © 2019 Srđan Marković. All rights reserved.
//

import Foundation
import ScreenSaver
import SceneKit
import GameKit

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

    // MARK: - Cache
    
    private struct Cache {
        static let rbtWhite: NSColor = NSColor(red: 1, green: 1, blue: 1, alpha: 1)
        static let rbtBlack: NSColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
        static let rbtRed: NSColor = NSColor(red: 210 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1)
        
        static let rbtWhites: [CGPoint] = [
            CGPoint(x: 8, y: 3),
            CGPoint(x: 8, y: 4),
            CGPoint(x: 12, y: 6),
            CGPoint(x: 8, y: 5),
            CGPoint(x: 10, y: 6),
            CGPoint(x: 11, y: 7),
            CGPoint(x: 6, y: 7),
            CGPoint(x: 11, y: 8),
            CGPoint(x: 9, y: 8),
            CGPoint(x: 6, y: 8),
            CGPoint(x: 4, y: 8),
            CGPoint(x: 12, y: 9),
            CGPoint(x: 7, y: 9),
            CGPoint(x: 11, y: 10),
            CGPoint(x: 9, y: 10),
            CGPoint(x: 5, y: 10),
            CGPoint(x: 10, y: 11),
            CGPoint(x: 6, y: 11),
            CGPoint(x: 9, y: 12),
            CGPoint(x: 7, y: 12)
        ]
        static let rbtBlacks: [CGPoint] = [
            CGPoint(x: 7, y: 3),
            CGPoint(x: 7, y: 4),
            CGPoint(x: 7, y: 5),
            CGPoint(x: 11, y: 6),
            CGPoint(x: 9, y: 6),
            CGPoint(x: 8, y: 6),
            CGPoint(x: 7, y: 6),
            CGPoint(x: 6, y: 6),
            CGPoint(x: 5, y: 6),
            CGPoint(x: 10, y: 7),
            CGPoint(x: 9, y: 7),
            CGPoint(x: 8, y: 7),
            CGPoint(x: 7, y: 7),
            CGPoint(x: 5, y: 7),
            CGPoint(x: 4, y: 7),
            CGPoint(x: 10, y: 8),
            CGPoint(x: 8, y: 8),
            CGPoint(x: 7, y: 8),
            CGPoint(x: 5, y: 8),
            CGPoint(x: 3, y: 8),
            CGPoint(x: 11, y: 9),
            CGPoint(x: 10, y: 9),
            CGPoint(x: 9, y: 9),
            CGPoint(x: 8, y: 9),
            CGPoint(x: 6, y: 9),
            CGPoint(x: 5, y: 9),
            CGPoint(x: 4, y: 9),
            CGPoint(x: 10, y: 10),
            CGPoint(x: 8, y: 10),
            CGPoint(x: 7, y: 10),
            CGPoint(x: 6, y: 10),
            CGPoint(x: 4, y: 10),
            CGPoint(x: 3, y: 10),
            CGPoint(x: 9, y: 11),
            CGPoint(x: 8, y: 11),
            CGPoint(x: 7, y: 11),
            CGPoint(x: 5, y: 11),
            CGPoint(x: 4, y: 11),
            CGPoint(x: 8, y: 12),
            CGPoint(x: 6, y: 12)
        ]
        static let rbtReds: [CGPoint] = [
            CGPoint(x: 12, y: 2),
            CGPoint(x: 11, y: 2),
            CGPoint(x: 10, y: 2),
            CGPoint(x: 9, y: 2),
            CGPoint(x: 12, y: 3),
            CGPoint(x: 11, y: 3),
            CGPoint(x: 10, y: 3),
            CGPoint(x: 9, y: 3),
            CGPoint(x: 6, y: 3),
            CGPoint(x: 5, y: 3),
            CGPoint(x: 4, y: 3),
            CGPoint(x: 3, y: 3),
            CGPoint(x: 2, y: 3),
            CGPoint(x: 12, y: 4),
            CGPoint(x: 11, y: 4),
            CGPoint(x: 10, y: 4),
            CGPoint(x: 9, y: 4),
            CGPoint(x: 6, y: 4),
            CGPoint(x: 5, y: 4),
            CGPoint(x: 4, y: 4),
            CGPoint(x: 3, y: 4),
            CGPoint(x: 2, y: 4),
            CGPoint(x: 12, y: 5),
            CGPoint(x: 11, y: 5),
            CGPoint(x: 10, y: 5),
            CGPoint(x: 9, y: 5),
            CGPoint(x: 6, y: 5),
            CGPoint(x: 5, y: 5),
            CGPoint(x: 4, y: 5),
            CGPoint(x: 3, y: 5),
            CGPoint(x: 2, y: 5),
            CGPoint(x: 4, y: 6),
            CGPoint(x: 3, y: 6),
            CGPoint(x: 2, y: 6),
            CGPoint(x: 13, y: 7),
            CGPoint(x: 12, y: 7),
            CGPoint(x: 3, y: 7),
            CGPoint(x: 2, y: 7),
            CGPoint(x: 13, y: 8),
            CGPoint(x: 12, y: 8),
            CGPoint(x: 12, y: 10),
            CGPoint(x: 12, y: 11),
            CGPoint(x: 11, y: 11),
            CGPoint(x: 3, y: 11),
            CGPoint(x: 12, y: 12),
            CGPoint(x: 11, y: 12),
            CGPoint(x: 10, y: 12),
            CGPoint(x: 5, y: 12),
            CGPoint(x: 4, y: 12),
            CGPoint(x: 3, y: 12),
            CGPoint(x: 5, y: 13),
            CGPoint(x: 4, y: 13),
            CGPoint(x: 3, y: 13)
        ]
    }

    // MARK: - Colors
    
    var rbtWhite: NSColor { return Cache.rbtWhite }
    var rbtBlack: NSColor { return Cache.rbtBlack }
    var rbtRed: NSColor { return Cache.rbtRed }
    
    var rbtWhites: [CGPoint] { return Cache.rbtWhites }
    var rbtBlacks: [CGPoint] { return Cache.rbtBlacks }
    var rbtReds: [CGPoint] { return Cache.rbtReds }

    // MARK: - SceneKit

    lazy var sceneView: SCNView = {
        
//        // Initialize the SceneKit view
//        let options = [
//
//            // Use OpenGL 3.2
//            SCNView.Option.preferredRenderingAPI.rawValue: NSNumber(value: SCNRenderingAPI.openGLCore32.rawValue),
//
//            // Use Metal
//            SCNView.Option.preferredRenderingAPI.rawValue: NSNumber(value: SCNRenderingAPI.metal.rawValue),
//
//            // Use a default device as preferred
//            SCNView.Option.preferredDevice.rawValue: MTLCreateSystemDefaultDevice() as Any,
//
//            // Use a low-power device as preferred
//            SCNView.Option.preferLowPowerDevice.rawValue: NSNumber(booleanLiteral: true)
//        ]
//        let sceneView = SCNView.init(frame: self.bounds, options: options)
        let sceneView = SCNView.init(frame: self.bounds)
        
        // create a new scene
        let scene = SCNScene()

        let boxSize = CGFloat(2.0)
                        
        // create a logo
        let logoNode = SCNNode()
        
        let whiteBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0.0)
        whiteBox.firstMaterial!.diffuse.contents = self.rbtWhite
        whiteBox.firstMaterial!.specular.contents = self.rbtWhite

        let whiteNodes = SCNNode()
        whiteNodes.position = SCNVector3(x: -8 * boxSize, y: -8 * boxSize, z: 0.0)
        self.rbtWhites.forEach { p in
            let box = SCNNode(geometry: whiteBox)
            box.name = "box"
            box.position = SCNVector3(x: p.x * boxSize, y: p.y * boxSize, z: 0.0)
            box.physicsBody = SCNPhysicsBody(type: .kinematic, shape: .init(node: box, options: nil))
            //box.physicsBody = SCNPhysicsBody(type: .dynamic, shape: .init(node: box, options: nil))
            //box.physicsBody?.mass = 1.0
            //box.physicsBody?.restitution = 0.5
            box.physicsField = SCNPhysicsField.noiseField(smoothness: CGFloat.random(in: 0...1), animationSpeed: CGFloat.random(in: 0...1))
            whiteNodes.addChildNode(box)
        }
        logoNode.addChildNode(whiteNodes)

        let blackBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0.0)
        blackBox.firstMaterial!.diffuse.contents = self.rbtBlack
        blackBox.firstMaterial!.specular.contents = self.rbtBlack

        let blackNodes = SCNNode()
        blackNodes.position = SCNVector3(x: -8 * boxSize, y: -8 * boxSize, z: 0.0)
        self.rbtBlacks.forEach { p in
            let box = SCNNode(geometry: blackBox)
            box.name = "box"
            box.position = SCNVector3(x: p.x * boxSize, y: p.y * boxSize, z: 0.0)
            box.physicsBody = SCNPhysicsBody(type: .kinematic, shape: .init(node: box, options: nil))
            //box.physicsBody = SCNPhysicsBody(type: .dynamic, shape: .init(node: box, options: nil))
            //box.physicsBody?.mass = 1.0
            //box.physicsBody?.restitution = 0.5
            box.physicsField = SCNPhysicsField.noiseField(smoothness: CGFloat.random(in: 0...1), animationSpeed: CGFloat.random(in: 0...1))
            blackNodes.addChildNode(box)
        }
        logoNode.addChildNode(blackNodes)

        let redBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0.0)
        redBox.firstMaterial!.diffuse.contents = self.rbtRed
        redBox.firstMaterial!.specular.contents = self.rbtRed

        let redNodes = SCNNode()
        redNodes.position = SCNVector3(x: -8 * boxSize, y: -8 * boxSize, z: 0.0)
        self.rbtReds.forEach { p in
            let box = SCNNode(geometry: redBox)
            box.name = "box"
            box.position = SCNVector3(x: p.x * boxSize, y: p.y * boxSize, z: 0.0)
            box.physicsBody = SCNPhysicsBody(type: .kinematic, shape: .init(node: box, options: nil))
            //box.physicsBody = SCNPhysicsBody(type: .dynamic, shape: .init(node: box, options: nil))
            //box.physicsBody?.mass = 1.0
            //box.physicsBody?.restitution = 0.5
            box.physicsField = SCNPhysicsField.noiseField(smoothness: CGFloat.random(in: 0...1), animationSpeed: CGFloat.random(in: 0...1))
            redNodes.addChildNode(box)
        }
        logoNode.addChildNode(redNodes)

        scene.rootNode.addChildNode(logoNode)

        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 64)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 64, z: 64)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
                
        // animate the logo node
        logoNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 1)))
        
//        // animate the logo "box" nodes
//        logoNode.childNodes { (node, _) -> Bool in
//            return node.name == "box"
//        }.forEach { (node) in
//            node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0, z: 1, duration: 1)))
//        }
        
        // set the scene to the view
        sceneView.scene = scene
        
        // allows the user to manipulate the camera
        sceneView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // configure the view
        sceneView.backgroundColor = .black
        
        return sceneView
    }()

    // MARK: - Initialization
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)

        // Add SceneKit view (initialized lazily)
        self.addSubview(self.sceneView)

        // Use auto-layout
        self.sceneView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.sceneView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.sceneView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.sceneView.topAnchor.constraint(equalTo: self.topAnchor),
            self.sceneView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    deinit {
        self.sceneView.removeFromSuperview()
    }

    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ScreenSaverView
    
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

        // ...

        setNeedsDisplay(bounds)
    }

    override func stopAnimation() {
        guard isPreview else {
            return
        }

        super.stopAnimation()
    }
}
