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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = UIColor.redColor()
        
        let skView = SKView(frame: self.view.frame)
        self.view.addSubview(skView)
        skView.multipleTouchEnabled = true
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        let analog = UIView(frame: CGRect(x: self.view.frame.size.width-100, y: self.view.frame.size.height-100, width: 80, height: 80))
        analog.backgroundColor = UIColor.redColor()
        analog.layer.cornerRadius = 40
        self.view.addSubview(analog)
        
        analog.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: "analogTap"))

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func analogTap(){
        //scene.stickJump()
    }

}
