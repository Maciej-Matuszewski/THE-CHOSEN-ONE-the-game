//
//  Fireball.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 19.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import UIKit
import SpriteKit

class Fireball: SKSpriteNode, SKPhysicsContactDelegate  {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(scene :GameScene!) {
        
        let atlas = SKTextureAtlas(named: "fireball")
        var textures = [SKTexture]()
        
        let numImages = atlas.textureNames.count
        for var i=1; i<=numImages; i++ {
            textures.append(atlas.textureNamed("fireball_\(i)"))
        }
        
        let kSize : CGFloat = 0.5
        super.init(texture: textures[0], color: UIColor.clearColor(), size: CGSize(width: textures[0].size().width * kSize, height: textures[0].size().height * kSize))
        
        position.y = scene.stick.position.y + scene.stick.size.height/3
        position.x = scene.stick.position.x + (scene.stick.direction == Stick.stickDirection.Right ? scene.stick.size.width/2 : -scene.stick.size.width/4)
        
        
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width*0.5)
        physicsBody?.dynamic = false
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = GameScene.PhysicsCategory.Fireball
        physicsBody?.contactTestBitMask = GameScene.PhysicsCategory.None
        physicsBody?.collisionBitMask = GameScene.PhysicsCategory.Background
        
        
        
        var ax : Double = Double(scene.analog.analogStick.position.x*20)
        let ay : Double = Double(scene.analog.analogStick.position.y*20)
        let bx : Double = 0
        let by : Double = -100
        
        if(ax==0 && ay == 0){
            ax = scene.stick.direction == Stick.stickDirection.Right ? 400 : -400
        }
        
        let wynik : Double = (ax*bx + ay*by)/(sqrt(pow(ax, 2)+pow(ay, 2)) * sqrt(pow(bx, 2)+pow(by, 2)))
        
        var obrot :Double = 0
        if(ax==0 && ay < 0){ obrot = M_PI_2*0 }
        else if(ax>0 && ay == 0){ obrot = M_PI_2*1 }
        else if(ax==0 && ay > 0){ obrot = M_PI_2*2 }
        else if(ax<0 && ay == 0){ obrot = M_PI_2*3 }
        
        else if(ax > 0 && ay < 0){ obrot = M_PI_2*1 - wynik }
        else if(ax < 0 && ay < 0){ obrot = M_PI_2*3 + wynik }
        else if(ax > 0 && ay > 0){ obrot = M_PI_2*1 + abs(wynik) }
        else if(ax < 0 && ay > 0){ obrot = M_PI_2*3 + wynik }
        
        zRotation = CGFloat(obrot)
        
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(textures, timePerFrame: 0.075, resize: false, restore: true)))
        runAction(SKAction.sequence([
            
            SKAction.moveBy(CGVector(dx: ax, dy: ay), duration: 1.5),
            SKAction.fadeOutWithDuration(0.3)
            
            ])) { () -> Void in
            self.removeFromParent()
        }
        
    }
    
    
}
