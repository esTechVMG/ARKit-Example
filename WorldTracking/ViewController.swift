//
//  ViewController.swift
//  WorldTracking
//
//  Created by A4-iMAC01 on 09/02/2021.
//

import UIKit
import ARKit
class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        initSession()
        
        self.sceneView.autoenablesDefaultLighting = true
    }

    @IBAction func addBtn(_ sender: Any) {
        /*
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.geometry?.firstMaterial?.specular.contents = UIColor.blue
        
        let x = self.randomNumber(firstNum: -0.3, secondNum: 0.3)
        let y = self.randomNumber(firstNum: -0.3, secondNum: 0.3)
        let z = self.randomNumber(firstNum: -0.3, secondNum: 0.3)
        node.position = SCNVector3(x,y,z)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        */
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        let node = SCNNode()
        node.geometry = shape
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    @IBAction func restartButton(_ sender: Any) {
        
    }
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes({(node,_) in
            node.removeFromParentNode()
        })
        initSession()
    }
    func initSession(){
        self.sceneView.session.run(configuration,options: [.resetTracking,.removeExistingAnchors])
    }
    func randomNumber(firstNum:CGFloat,secondNum:CGFloat) -> CGFloat {
        CGFloat(arc4random()) /  CGFloat(UINT32_MAX) * abs(firstNum-secondNum) + min(firstNum,secondNum)
    }
}

