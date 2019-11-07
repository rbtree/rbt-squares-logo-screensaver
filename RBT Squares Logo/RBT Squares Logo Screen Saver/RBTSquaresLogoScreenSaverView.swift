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
import simd

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
        static let rbtWhite = NSColor(red: 1, green: 1, blue: 1, alpha: 1)
        static let rbtBlack = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
        static let rbtRed = NSColor(red: 210 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1)
        
        static let rbtLogo: [[Int]] = [
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 1, 1, 2, 3, 2, 3, 1, 1, 1, 0, 0, 0],
            [0, 0, 0, 1, 2, 2, 3, 2, 2, 2, 3, 1, 1, 0, 0, 0],
            [0, 0, 0, 2, 2, 3, 2, 2, 2, 3, 2, 3, 1, 0, 0, 0],
            [0, 0, 0, 0, 2, 2, 2, 3, 2, 2, 2, 2, 3, 0, 0, 0],
            [0, 0, 0, 2, 3, 2, 3, 2, 2, 3, 2, 3, 1, 1, 0, 0],
            [0, 0, 1, 1, 2, 2, 3, 2, 2, 2, 2, 3, 1, 1, 0, 0],
            [0, 0, 1, 1, 1, 2, 2, 2, 2, 2, 3, 2, 3, 0, 0, 0],
            [0, 0, 1, 1, 1, 1, 1, 2, 3, 1, 1, 1, 1, 0, 0, 0],
            [0, 0, 1, 1, 1, 1, 1, 2, 3, 1, 1, 1, 1, 0, 0, 0],
            [0, 0, 1, 1, 1, 1, 1, 2, 3, 1, 1, 1, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        ]
        
        static let boxSize = CGFloat(2.0)

        static var boxTypes: [SCNBox] {
            let whiteBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0.0)
            whiteBox.firstMaterial!.diffuse.contents = self.rbtWhite
            whiteBox.firstMaterial!.specular.contents = self.rbtWhite
            
            let blackBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0.0)
            blackBox.firstMaterial!.diffuse.contents = self.rbtBlack
            blackBox.firstMaterial!.specular.contents = self.rbtWhite.withAlphaComponent(0.25)
            
            let redBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0.0)
            redBox.firstMaterial!.diffuse.contents = self.rbtRed
            redBox.firstMaterial!.specular.contents = self.rbtWhite.withAlphaComponent(0.25)

            return [
                SCNBox(),
                redBox,
                blackBox,
                whiteBox
            ]
        }
        
        static var logoNode: SCNNode {
            // create a logo
            let logoNode = SCNNode()
            logoNode.name = "logo"
            
            let boxNodes = SCNNode()
            
            let bpm = Double.random(in: 60.0...120.0) /* normal beats per minute */
            let bps = bpm / 60.0 /* per second */
            let bd = 1.0 / bps /* beat duration */
            
            // index offset
            let off = Float(self.rbtLogo.count - 1) / 2.0
            
            for (j, row) in self.rbtLogo.enumerated() {
                var rowVals = [Any]()
                for (i, value) in row.enumerated() {
                    // offset index in a matrix
                    let ox = Float(i) - off /* -off to +off, depending to a position in a row */
                    let oy = off - Float(j) /* +off to -off, depending to a position in a col */

                    // absolute positions per offset index in a matrix
                    let xpos = self.boxSize * CGFloat(ox) /* -off * boxSize to +off * boxSize, depending on a position in a row */
                    let ypos = self.boxSize * CGFloat(oy) /* -off * boxSize to +off * boxSize, depending on a position in a col */
                    let zpos = CGFloat(0.0) /* 0.0 */
                    
                    // absolute transitions per offset index in a matrix
                    let xtrans = self.boxSize * CGFloat(ox / off) /* -boxSize to 0 to +boxSize, depending to a position in a row, more at the edges */
                    let ytrans = self.boxSize * CGFloat(oy / off) /* -boxSize to 0 to +boxSize, depending to a position in a col, more at the edges */
                    let ztrans = self.boxSize * CGFloat((off - max(abs(ox), abs(oy))) / off) /* 0 to +boxSize to 0, depending to a position in a matrix, more at the center */

                    // absolute rotations per offset index in a matrix
                    //let xrot = CGFloat(ox / off) * .pi / 6.0
                    //let yrot = CGFloat(oy / off) * .pi / 6.0
                    //let zrot = CGFloat(0.0)

                    rowVals.append(xtrans)

                    guard value != 0 else { continue }
                    
                    let boxType = self.boxTypes[value]
                    let box = SCNNode(geometry: boxType)
                    box.name = "box"
                    
                    box.position = SCNVector3(x: xpos, y: ypos, z: zpos)
                    //box.physicsBody = SCNPhysicsBody(type: .kinematic, shape: .init(node: box, options: nil))
                    //box.physicsBody = SCNPhysicsBody(type: .dynamic, shape: .init(node: box, options: nil))
                    //box.physicsBody?.mass = 1.0
                    //box.physicsBody?.restitution = 0.5
                    //box.physicsField = SCNPhysicsField.noiseField(smoothness: CGFloat.random(in: 0...1), animationSpeed: CGFloat.random(in: 0...1))
                    box.runAction(
                        SCNAction.repeatForever(
                            SCNAction.sequence([
                                // 1/3
                                SCNAction.group([
                                    SCNAction.moveBy(x: xtrans, y: ytrans, z: ztrans, duration: bd / 3.0),
                                    //SCNAction.rotateBy(x: xrot, y: yrot, z: zrot, duration: bd / 3.0),
                                ]),
                                // 2/3
                                SCNAction.group([
                                    //SCNAction.rotateBy(x: -xrot, y: -yrot, z: -zrot, duration: bd / 3.0),
                                    SCNAction.moveBy(x: -xtrans, y: -ytrans, z: -ztrans, duration: bd / 3.0),
                                ]),
                                // 3/3
                                SCNAction.wait(duration: bd / 3.0),
                            ])
                        )
                    )
                    boxNodes.addChildNode(box)
                }
                debugPrint(rowVals)
            }
            logoNode.addChildNode(boxNodes)

            //logoNode.runAction(
            //    SCNAction.repeatForever(
            //        SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 1)
            //    )
            //)

            return logoNode
        }
    }

    // MARK: - Colors
    
    var rbtWhite: NSColor { return Cache.rbtWhite }
    var rbtBlack: NSColor { return Cache.rbtBlack }
    var rbtRed: NSColor { return Cache.rbtRed }
    var rbtLogo: [[Int]] { return Cache.rbtLogo }
    var boxSize: CGFloat { return Cache.boxSize }
    var boxTypes: [SCNBox] { return Cache.boxTypes }
    var logoNode: SCNNode { return Cache.logoNode }

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
        scene.rootNode.addChildNode(self.logoNode)

        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.name = "camera"
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 32)
        //cameraNode.rotation = SCNVector4(x: .pi/4, y: 0, z: 0, w: 1)

        // create and add a light to the scene
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = .omni
        omniLightNode.position = SCNVector3(x: 0, y: 64, z: 64)
        scene.rootNode.addChildNode(omniLightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
//        // animate the logo "box" and "logo" nodes
//        scene.rootNode.childNodes { (node, _) -> Bool in
//            switch node.name {
//            case "camera":
//                node.runAction(
//                    SCNAction.repeatForever(
//                        SCNAction.rotateBy(
//                            x: 0,
//                            y: 0,
//                            z: 1,
//                            duration: 1
//                        )
//                    )
//                )
//            case "logo":
//                node.runAction(
//                    SCNAction.repeatForever(
//                        SCNAction.rotateBy(
//                            x: 0,
//                            y: 1,
//                            z: 0,
//                            duration: Double.random(in: 1...2)
//                        )
//                    )
//                )
//            case "box":
//                node.runAction(
//                    SCNAction.repeatForever(
//                        SCNAction.rotateBy(
//                            x: CGFloat(Double.random(in: 1...2)),
//                            y: 0,
//                            z: CGFloat(Double.random(in: 1...2)),
//                            duration: Double.random(in: 1...2)
//                        )
//                    )
//                )
//            default:
//                break
//            }
//            return false
//        }

        // set the scene to the view
        sceneView.scene = scene
        
        #if DEBUG
        // allows the user to manipulate the camera
        sceneView.allowsCameraControl = true
        #endif
        
        #if DEBUG
        // show statistics such as fps and timing information
        sceneView.showsStatistics = true
        #endif
        
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
//        self.sceneView.start()
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
