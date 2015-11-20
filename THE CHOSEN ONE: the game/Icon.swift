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
        let texture = SKTexture(imageNamed: "ut")
        let kSize = (CGFloat(arc4random_uniform(5)))
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 10*kSize+30, height: 10*kSize+30))
        position.y = scene.size.height/2
        repeat{
            position.x = CGFloat(arc4random_uniform(UInt32(scene.size.width))) - scene.background.position.x + 200
            
        }while( lastIconPositionX - position.x >= 200 && lastIconPositionX - position.x <= -200)
        
        
        position.y = scene.size.height
        
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2*0.8)
        physicsBody?.dynamic = true
        
        physicsBody?.categoryBitMask = GameScene.PhysicsCategory.Icons
        physicsBody?.contactTestBitMask = GameScene.PhysicsCategory.None
        physicsBody?.collisionBitMask = GameScene.PhysicsCategory.None
        
        self.runAction(SKAction.fadeOutWithDuration(10)) { () -> Void in
            self.removeFromParent()
        }
        
    }
    
}
