//
//  HUD.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 18.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import UIKit
import SpriteKit

class HUD: SKSpriteNode {
    
    var heartOne : SKSpriteNode!
    var heartTwo : SKSpriteNode!
    var heartThree : SKSpriteNode!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(scene: GameScene!) {

        super.init(texture: SKTexture(imageNamed: "HUD_Background_Image"), color: UIColor.redColor(), size: CGSize(width: 300, height: 100))
        position = CGPoint(x: 150, y: scene.size.height-50)
        
        heartOne = SKSpriteNode(imageNamed: "heart")
        heartOne.size = CGSize(width: 30, height: 30)
        heartOne.position = CGPoint(x: -40, y: 25)
        self.addChild(heartOne)
        
        heartTwo = SKSpriteNode(imageNamed: "heart")
        heartTwo.size = CGSize(width: 30, height: 30)
        heartTwo.position = CGPoint(x: 0, y: 25)
        self.addChild(heartTwo)
        
        heartThree = SKSpriteNode(imageNamed: "heart")
        heartThree.size = CGSize(width: 30, height: 30)
        heartThree.position = CGPoint(x: +40, y: 25)
        self.addChild(heartThree)
        
    }
    
}
