//
//  GameViewController.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 15.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import SpriteKit
import UIKit

class GameViewController: UIViewController {

    var scene: GameScene!
    var analog: UIView!
    var analogCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        skView.multipleTouchEnabled = true
        
        skView.showsFields = true
        skView.showsNodeCount = true
        skView.showsFPS = true
        skView.showsPhysics = true
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFit
        scene.backgroundColor = UIColor.darkGrayColor()
        skView.presentScene(scene)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
