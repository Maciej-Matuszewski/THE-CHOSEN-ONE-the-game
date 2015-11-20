//
//  Stick.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 16.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import UIKit
import SpriteKit

class Stick: SKSpriteNode, SKPhysicsContactDelegate {
    
    enum stickState : Int {
        case Running
        case Standing
        case Walking
    }
    
    enum stickDirection : Int {
        case Left
        case Right
    }
    
    var state: stickState!
    var direction: stickDirection!
    var jumping: Bool!
    
    var myScene : GameScene!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(scene: GameScene!) {
        myScene = scene
        
        
        let texture = SKTextureAtlas(named: "stick_stand_right").textureNamed("stick_stand_1")
        super.init(texture: texture, color: UIColor.redColor(), size: CGSize(width: texture.size().width/2, height: texture.size().height/2))
        self.position = CGPoint(x: -myScene.background.size.width/2+200, y: -myScene.background.size.height/2+size.height/2)
        
        physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: size.width/200*60, height: size.height))
        physicsBody?.dynamic = true
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = GameScene.PhysicsCategory.Player
        physicsBody?.contactTestBitMask = GameScene.PhysicsCategory.Background
        physicsBody?.collisionBitMask = GameScene.PhysicsCategory.Background
        
        
        direction = stickDirection.Right
        jumping = false
        
        stand()
        //enterToScene()
        
        
        
    }
    
    func enterToScene(){
        let stickRunning = genTexture("stick_run_right", fileName: "stick_run_")
        
        self.runAction(SKAction.group([
            SKAction.repeatAction(SKAction.animateWithTextures(stickRunning, timePerFrame: 0.075, resize: false, restore: true), count: 2),
            SKAction.moveTo(CGPoint(x: -myScene.background.size.width/2+150, y: -myScene.background.size.height/2+size.height/2+5), duration: 1.35)
            ])) { () -> Void in
                
        }
    }
    
    
    func move(vectorX : CGFloat){
        
        if(abs(vectorX) < 15){
            if((vectorX > 0 && direction == stickDirection.Left) || (vectorX < 0 && direction == stickDirection.Right) || (state != stickState.Walking)){
                direction = vectorX > 0 ? stickDirection.Right : stickDirection.Left
                walk()
            }
        }else{
            if((vectorX > 0 && direction == stickDirection.Left) || (vectorX < 0 && direction == stickDirection.Right) || (state != stickState.Running)){
                direction = vectorX > 0 ? stickDirection.Right : stickDirection.Left
                run()
            }
        }
        
    }
    
    func run(){
        
        removeActionForKey("Walk")
        
        state = stickState.Running
        
        let textures = genTexture("stick_run_\(direction == stickDirection.Right ? "right" : "left")", fileName: "stick_run_")
        
        self.runAction(SKAction.group([
            
            SKAction.repeatActionForever(SKAction.animateWithTextures(textures, timePerFrame: 0.075, resize: false, restore: true)),
            SKAction.repeatActionForever(SKAction.moveByX(direction == stickDirection.Right ? 2 : -2, y: 0, duration: 0.01))
            ]), withKey: "Run")
    }
    
    func walk(){
        
        removeActionForKey("Run")
        
        state = stickState.Walking
        
        let textures = genTexture("stick_walk_\(direction == stickDirection.Right ? "right" : "left")", fileName: "stick_walk_")
        
        self.runAction(SKAction.group([
            
            SKAction.repeatActionForever(SKAction.animateWithTextures(textures, timePerFrame: 0.075, resize: false, restore: true)),
            SKAction.repeatActionForever(SKAction.moveByX(direction == stickDirection.Right ? 0.5 : -0.5, y: 0, duration: 0.01))
            ]), withKey: "Walk")
    }

    
    func jump(){
        if(!jumping){
            
            jumping = true
            
            physicsBody?.applyImpulse(CGVector(dx: 0, dy: 25), atPoint: CGPoint(x: 0, y: -50))
            
            let textures = state == stickState.Standing ?  genTexture("stick_jump_central", fileName: "stick_jump_") : genTexture("stick_jump_\(direction == stickDirection.Right ? "right" : "left")", fileName: "stick_jump_")
            self.runAction(SKAction.repeatAction(SKAction.animateWithTextures(textures, timePerFrame: 0.075, resize: false, restore: true), count: 1)) { () -> Void in
                    self.jumping = false
            }
            
        }
    }
    
    func stand(){
        state = stickState.Standing
        
        var textures = genTexture("stick_stand_\(direction == stickDirection.Right ? "right" : "left")", fileName: "stick_stand_")
        for _ in 0...40 {
            textures.append(SKTextureAtlas(named: "stick_stand_\(direction == stickDirection.Right ? "right" : "left")").textureNamed("stick_stand_1"))
        }
        
        textures = textures.reverse()
        
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(textures, timePerFrame: 0.075, resize: false, restore: true)), withKey:"stand")
    }
    
    func hit(){
        
        removeActionForKey("Run")
        removeActionForKey("Walk")
        
        let textures = genTexture("stick_fireball_\(direction == stickDirection.Right ? "right" : "left")", fileName: "stick_fireball_")
        
        self.runAction(SKAction.animateWithTextures(textures, timePerFrame: 0.04, resize: false, restore: true)) { () -> Void in
            
            if(self.state == stickState.Running){
                self.run()
            }else if(self.state == stickState.Walking){
                self.walk()
            }
            
        }
        
        myScene.background.addChild(Fireball(scene: myScene))
        
    }
    
    func stop(){
        if(jumping == true){
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                
                self.jumping = false
            }
        }
        
        removeAllActions()
        stand()
    }
    
    func genTexture(atlasName:String, fileName: String) ->[SKTexture]{
    
        
        let atlas = SKTextureAtlas(named: atlasName)
        var texture = [SKTexture]()
        
        let numImages = atlas.textureNames.count
        for var i=1; i<=numImages; i++ {
            texture.append(atlas.textureNamed("\(fileName)\(i)"))
        }

        return texture
    }

}
