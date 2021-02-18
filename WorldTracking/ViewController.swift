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
        let scene = SCNNode()
        let ground = SCNNode(geometry: SCNPlane(width: 1, height: 1))
        ground.position = SCNVector3(0,0,0)
        ground.rotation = SCNVector4(1, 0, 0, 270.degreesToRadians)
        ground.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        let base = SCNBox(width: 0.25, height: 0.25, length: 0.25, chamferRadius: 0.0)
        base.firstMaterial?.diffuse.contents = UIColor.yellow
        let baseNode = SCNNode(geometry: base)
        baseNode.position = SCNVector3(0.0,0.125,0)
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.1, height: 0.2))
        doorNode.position = SCNVector3(0.1250001, 0, 0)
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        doorNode.rotation = SCNVector4(0, 1, 0, 90.degreesToRadians)
        
        let roof = SCNPyramid(width: 0.25, height:0.125, length: 0.25)
        roof.firstMaterial?.diffuse.contents = UIColor.brown
        let roofNode = SCNNode(geometry: roof)
        roofNode.position = SCNVector3(0.0,0.25,0.0)
        scene.addChildNode(roofNode)
        scene.addChildNode(ground)
        scene.addChildNode(baseNode)
        scene.addChildNode(doorNode)
        self.sceneView.scene.rootNode.addChildNode(scene)
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
        /*
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        
        
        node.geometry = shape
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        node.position = SCNVector3(0,0,0.3)
        node.eulerAngles = SCNVector3(90.degreesToRadians,0,0)
        */
        
    }
    @IBAction func restartButton(_ sender: Any) {
        restartSession()
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
//Degrees to radians
extension Int {
    var degreesToRadians:Double{return Double(self) * .pi/180}
}
