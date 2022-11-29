//
//  ViewController.swift
//  SampleProject
//
//  Created by Neosoft on 04/11/22.
//

import UIKit
import ARKit

class ARViewController: ViewController {
    
    @IBOutlet weak var arSceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfigurationAndRunSession()
        //        addBox()
        setupObjectNode()
        addTapGestureToARSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConfigurationAndRunSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopARSession()
    }
    
    private func setupConfigurationAndRunSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.worldAlignment = .gravity
        arSceneView.session.run(configuration)
    }
    
    private func stopARSession() {
        arSceneView.session.pause()
    }
    
    override func setupNavigationBar(isHidden: Bool = true) {
        super.setupNavigationBar(isHidden: false)
    }
    
    private func addBox(x: Float = 0, y: Float = 0, z: Float = -0.2) {
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(x, y, z)
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        arSceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    func setupObjectNode(x: Float = 0, y: Float = 0, z: Float = -0.2) {
        // Create and add a camera to the scene:
        if let scene = SCNScene(named: "art.scnassets/grenadeScene.scn"), let node = scene.rootNode.childNode(withName: "grenade", recursively: true) {
                node.position = SCNVector3(x: x, y: y, z: z)
                node.geometry?.firstMaterial?.diffuse.contents = UIColor.green
                arSceneView.scene.rootNode.addChildNode(node)
                NodesStatus.added.printStatus()
                return
        }
        NodesStatus.notFound.printStatus()
    }
    
    @objc private func didTap(gesture: UIGestureRecognizer) {
        let tapLocation = gesture.location(in: arSceneView)
        let hitTestResults = arSceneView.hitTest(tapLocation)
        
        guard let node = hitTestResults.first?.node else {
            guard let hitTestQuery = arSceneView.raycastQuery(from: tapLocation, allowing: .existingPlaneInfinite, alignment: .any) else { NodesStatus.notFound.printStatus(); return }
            let hitTestResults = arSceneView.session.raycast(hitTestQuery)
            if let hitTestResultWithFeaturePoints = hitTestResults.first {
                let translation = hitTestResultWithFeaturePoints.worldTransform.translation
                //                addBox(x: translation.x, y: translation.y, z: translation.z)
                setupObjectNode(x: translation.x, y: translation.y, z: translation.z)
            }
            return
        }
        
        NodesStatus.removed.printStatus()
        node.removeFromParentNode()
    }
    
    private func addTapGestureToARSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap(gesture:)))
        arSceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
}



