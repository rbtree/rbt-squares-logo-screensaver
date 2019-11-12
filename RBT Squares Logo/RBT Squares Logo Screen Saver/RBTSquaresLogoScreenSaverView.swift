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

    // MARK: - Static variables

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
        
        //static let rbtLogoPulse: [[Float]] = [
        //    [0,32,48,56,60,62,63,64,64,63,62,60,56,48,32,0],
        //    [32,64,80,88,92,94,95,96,96,95,94,92,88,80,64,32],
        //    [48,80,96,104,108,110,111,112,112,111,110,108,104,96,80,48],
        //    [56,88,104,112,116,118,119,120,120,119,118,116,112,104,88,56],
        //    [60,92,108,116,120,122,123,124,124,123,122,120,116,108,92,60],
        //    [62,94,110,118,122,124,125,126,126,125,124,122,118,110,94,62],
        //    [63,95,111,119,123,125,126,127,127,126,125,123,119,111,95,63],
        //    [64,96,112,120,124,126,127,128,128,127,126,124,120,112,96,64],
        //    [64,96,112,120,124,126,127,128,128,127,126,124,120,112,96,64],
        //    [63,95,111,119,123,125,126,127,127,126,125,123,119,111,95,63],
        //    [62,94,110,118,122,124,125,126,126,125,124,122,118,110,94,62],
        //    [60,92,108,116,120,122,123,124,124,123,122,120,116,108,92,60],
        //    [56,88,104,112,116,118,119,120,120,119,118,116,112,104,88,56],
        //    [48,80,96,104,108,110,111,112,112,111,110,108,104,96,80,48],
        //    [32,64,80,88,92,94,95,96,96,95,94,92,88,80,64,32],
        //    [0,32,48,56,60,62,63,64,64,63,62,60,56,48,32,0]
        //]
        
        static let boxSize = CGFloat(2.0)
        
        static var boxTypes: [SCNBox] {
            let clearBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0.05)
            clearBox.firstMaterial?.diffuse.contents = self.rbtWhite.withAlphaComponent(0.05)
            clearBox.firstMaterial?.specular.contents = self.rbtWhite
            
            let whiteBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0.05)
            whiteBox.firstMaterial?.diffuse.contents = self.rbtWhite
            whiteBox.firstMaterial?.specular.contents = self.rbtWhite
            
            let blackBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0.05)
            blackBox.firstMaterial?.diffuse.contents = self.rbtBlack
            blackBox.firstMaterial?.specular.contents = self.rbtWhite
            
            let redBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0.05)
            redBox.firstMaterial?.diffuse.contents = self.rbtRed
            redBox.firstMaterial?.specular.contents = self.rbtWhite

            return [
                clearBox,
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
            boxNodes.name = "boxes"
            
            let bpm = Double.random(in: 60.0...100.0) /* normal beats per minute */
            let bps = bpm / 60.0 /* per second */
            let bd = 1.0 / bps /* beat duration */
            
            // index offset
            let off = Double(self.rbtLogo.count - 1) / 2.0
            
            // max rotation angle
            let srot = Double(.pi / 72.0)

            for (j, row) in self.rbtLogo.enumerated() {
                //var rowVals = [Any]()
                for (i, value) in row.enumerated() {
                    // offset index in a matrix
                    let ox = Double(i) - off /* -off to +off, depending to a position in a row */
                    let oy = off - Double(j) /* +off to -off, depending to a position in a col */

                    // absolute positions per offset index in a matrix
                    let xpos = self.boxSize * CGFloat(ox) /* -off * boxSize to +off * boxSize, depending on a position in a row */
                    let ypos = self.boxSize * CGFloat(oy) /* -off * boxSize to +off * boxSize, depending on a position in a col */
                    let zpos = CGFloat(0.0) /* 0.0 */
                                        
                    // absolute x and y transitions based on the offset index in a matrix
                    let xtrans = self.boxSize * CGFloat(ox / off) /* -boxSize to 0 to +boxSize, depending to a position in a row, more at the edges */
                    let ytrans = self.boxSize * CGFloat(oy / off) /* -boxSize to 0 to +boxSize, depending to a position in a col, more at the edges */
                    
                    // absolute z transition based on the offset index in a matrix
                    //let ztrans = self.boxSize * CGFloat(1.5 * (off - max(Swift.abs(ox), Swift.abs(oy))) / off) /* 0 to +boxSize to 0, depending to a position in a matrix, more at the center */
                    
                    // absolute z transition based on the logarithm
                    let ztrans = self.boxSize * CGFloat(simd.log((off - Swift.abs(ox)) * (off - Swift.abs(oy))))
                    
                    // absolute z transition based on the color in the logo
                    //let color = self.rbtLogo[j][i]
                    //let ztrans = self.boxSize * CGFloat(Float(color) / 2.0)
                    
                    // absolute z transition based on the predefined pulse matrix
                    //let pulse = self.rbtLogoPulse[j][i] / 128.0
                    //let ztrans = self.boxSize * CGFloat(pulse * 2.0)
                    
                    //rowVals.append(String(format: "%.3f", ztrans))

                    // absolute rotations based on the offset index in a matrix
                    //let xrot = CGFloat(srot) * CGFloat(-sign(oy) * (off - max(Swift.abs(ox), Swift.abs(oy))) / off)
                    //let yrot = CGFloat(srot) * CGFloat(sign(ox) * (off - max(Swift.abs(ox), Swift.abs(oy))) / off)
                    //let zrot = CGFloat(0.0)

                    // absolute rotations based on the logarithm
                    let xrot = CGFloat(srot) * CGFloat(-sign(oy) * (log((Swift.abs(ox) + 1.0) * (Swift.abs(oy) + 1.0))))
                    let yrot = CGFloat(srot) * CGFloat(sign(ox) * (log((Swift.abs(ox) + 1.0) * (Swift.abs(oy) + 1.0))))
                    let zrot = CGFloat(0.0)

                    // exclude empty boxes
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
                                    SCNAction.rotateBy(x: xrot, y: yrot, z: zrot, duration: bd / 3.0),
                                ]),
                                // 2/3
                                SCNAction.group([
                                    SCNAction.rotateBy(x: -xrot, y: -yrot, z: -zrot, duration: bd / 3.0),
                                    SCNAction.moveBy(x: -xtrans, y: -ytrans, z: -ztrans, duration: bd / 3.0),
                                ]),
                                
                                // 3/3
                                SCNAction.wait(duration: bd / 3.0),
                            ])
                        )
                    )
                    boxNodes.addChildNode(box)
                }
                //debugPrint(rowVals)
            }
            logoNode.addChildNode(boxNodes)

            //logoNode.runAction(
            //    SCNAction.repeatForever(
            //        SCNAction.rotateBy(x: 0, y: .pi / 2.0, z: 0, duration: bd)
            //    )
            //)

            return logoNode
        }
    }

    // MARK: - Variables
    
    var rbtWhite: NSColor { return Cache.rbtWhite }
    var rbtBlack: NSColor { return Cache.rbtBlack }
    var rbtRed: NSColor { return Cache.rbtRed }
    var rbtLogo: [[Int]] { return Cache.rbtLogo }
    var boxSize: CGFloat { return Cache.boxSize }

    // MARK: - SceneKit

    var boxTypes: [SCNBox] { return Cache.boxTypes }
    var logoNode: SCNNode { return Cache.logoNode }

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

        // place the camera directly above
        //cameraNode.position = SCNVector3(0, 0, 32)
        
        // place the camera on the top-left
        cameraNode.position = SCNVector3(16, -16, 32)
        cameraNode.orientation = SCNQuaternion(.pi/16, .pi/16, 0, 1.0)

        // create and add a light to the scene
        let omniLightNode = SCNNode()
        omniLightNode.name = "omni"
        omniLightNode.light = SCNLight()
        omniLightNode.light?.type = .omni
        omniLightNode.position = SCNVector3(x: -64, y: 32, z: 64)
        scene.rootNode.addChildNode(omniLightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.name = "ambient"
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = NSColor.darkGray
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
