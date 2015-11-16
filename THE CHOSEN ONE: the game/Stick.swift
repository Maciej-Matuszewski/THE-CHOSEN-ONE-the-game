//
//  Stick.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 16.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import UIKit
import SpriteKit

class Stick: SKSpriteNode {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        let texture = SKTexture(imageNamed: "stick_standing_001")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.position.x = 70
        self.position.y = 80
        
    }
    
    func run() {
        
        let stickRunningAtlas = SKTextureAtlas(named: "stick_run")
        var stickRunning = [SKTexture]()
        
        let numImages = stickRunningAtlas.textureNames.count
        for var i=1; i<=numImages; i++ {
            let stickRunningName = "stick_run_00\(i)"
            stickRunning.append(stickRunningAtlas.textureNamed(stickRunningName))
        }

        
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(stickRunning, timePerFrame: 0.1, resize: false, restore: true)), withKey:"run")
    }

}
