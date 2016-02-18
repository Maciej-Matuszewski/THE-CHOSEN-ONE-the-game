//
//  Icon.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 17.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import UIKit
import SpriteKit

class Icon: SKSpriteNode, SKPhysicsContactDelegate {
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(scene :GameScene!, lastIconPositionX : CGFloat!) {
        let texture = SKTexture(imageNamed: "apple")
        let kSize = (CGFloat(arc4random_uniform(5)))
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 10*kSize+30, height: 10*kSize+30))
        position.y = scene.size.height/2
        repeat{
            position.x = CGFloat(arc4random_uniform(UInt32(scene.size.width))) - scene.background.position.x + 200
            
        }while( lastIconPositionX - position.x >= 200 && lastIconPositionX - position.x <= -200)
        
        
        position.y = scene.size.height
        
        
        physicsBody = SKPhysicsBody(texture: texture, size: size) //(circleOfRadius: size.width/2*0.8)
        physicsBody?.dynamic = true
        
        physicsBody?.categoryBitMask = GameScene.PhysicsCategory.Enemy
        physicsBody?.contactTestBitMask = GameScene.PhysicsCategory.Player | GameScene.PhysicsCategory.Fireball
        physicsBody?.collisionBitMask = GameScene.PhysicsCategory.Background | GameScene.PhysicsCategory.Enemy | GameScene.PhysicsCategory.Player
        
        runAction(SKAction.fadeOutWithDuration(5)) { () -> Void in
            self.removeFromParent()
        }
        
        
    }
    
}
