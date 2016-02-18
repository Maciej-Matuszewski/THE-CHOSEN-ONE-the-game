//
//  Background.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 17.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import UIKit
import SpriteKit

class Background: SKSpriteNode, SKPhysicsContactDelegate {
    
    enum bgState : Int {
        case moving
        case standing
    }
    
    var state: bgState!
    
    var myScene : GameScene!
    
    var back : SKSpriteNode!
    
    var front : SKSpriteNode!

    init(scene: GameScene!) {
        myScene = scene
        let texture = SKTexture(imageNamed: "bg_level_0")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: myScene.size.height / texture.size().height * texture.size().width, height: myScene.size.height))
        position = CGPoint(x: size.width/2, y: size.height/2)
        state = bgState.standing
        
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody?.dynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = GameScene.PhysicsCategory.Background
        physicsBody?.contactTestBitMask = GameScene.PhysicsCategory.None
        physicsBody?.collisionBitMask = GameScene.PhysicsCategory.None
        
        
        back = SKSpriteNode(texture: SKTexture(imageNamed: "bg_level_0_back"), size: size)
        back.position = position
        front = SKSpriteNode(texture: SKTexture(imageNamed: "bg_level_0_front"), size: size)
        front.position = position
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkPosition(){
        if(position.x - (self.myScene.size.width/9*5) > -self.myScene.stick.position.x){
            position.x-=self.myScene.stick.state == Stick.stickState.Running ? 3.3 : 1.3
            if(position.x  < -(size.width/2 - myScene.size.width)){
                position.x = -(size.width/2 - myScene.size.width)
            }
            back.position = position
            front.position = position
        }else if(position.x - (self.myScene.size.width/7*2) < -self.myScene.stick.position.x){
            position.x+=self.myScene.stick.state == Stick.stickState.Running ? 3.3 : 1.3
            if(position.x > size.width/2){
                position.x = size.width/2
            }
            back.position = position
            front.position = position
        }
        
        if(self.myScene.stick.position.x > size.width/2){
           myScene.loadGame(myScene.level+1)
        }
        
        //if(self.myScene.stick.position.x < -size.width/2  && self.myScene.stick.state == Stick.stickState.RunningLeft){
            //self.myScene.stick.enterToScene()
            //self.myScene.stick.stop()
        //}

    }
    
}
