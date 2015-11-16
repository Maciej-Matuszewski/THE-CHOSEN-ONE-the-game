//
//  GameScene.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 15.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //let ship = SKSpriteNode(imageNamed: "Spaceship")
    //let background = SKSpriteNode(imageNamed: "skyBg")
    
    var stick : Stick!
    var stickRunning : [SKTexture]!
    
    //var jump : Bool!
    
    override func update(currentTime: CFTimeInterval) {
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        stick = Stick()
        addChild(stick)
        
        stick.run()
        
    }
    /*
    
    func stickRun() {
        stick.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(stickRunning, timePerFrame: 0.1, resize: false, restore: true)), withKey:"stickRun")
    }
    
    func stickJump(){
        if(!jump){
            jump = true
            stick.runAction(SKAction.moveToY(140, duration: 0.2)) { () -> Void in
                self.stick.runAction(SKAction.moveToY(80, duration: 0.2)) { () -> Void in
                    self.jump = false
                }
                
            }
        }
        
        
    }
    */
    

}
