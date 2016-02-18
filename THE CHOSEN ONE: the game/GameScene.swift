//
//  GameScene.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 15.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var background : Background!
    
    var stick : Stick!
    var icons : [Icon]!
    
    var analog : AnalogControl!
    var jumpButton : ButtonControl!
    var hitButton : ButtonControl!
    var hud : HUD!
    
    var level : Int!
    var timer : NSTimer!
    
    var lastIconPositionX : CGFloat!
    
    struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Background : UInt32 = 1
        static let Player   : UInt32 = 2
        static let Fireball : UInt32 = 8
        static let Enemy : UInt32 = 16
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        if(background != nil){
         
            background.checkPosition()
            
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        physicsWorld.gravity = CGVectorMake(0, -7)
        physicsWorld.contactDelegate = self
        
        loadGame(0)
        
    }
    
    func loadGame(level: Int){
        self.removeAllChildren()
        self.level = level
        
        background = Background(scene: self)
        addChild(background.back)
        addChild(background)
        addChild(background.front)
        
        
        stick = Stick(scene: self)
        background.addChild(stick)
        
        initControl()
        
        hud = HUD(scene: self)
        addChild(hud)
        
        
        lastIconPositionX = -background.size.width/2
        
        icons = [Icon]()
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = String("Level \(level)")
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint (x: size.width/2, y: size.height/2)
        addChild(label)
        
        label.runAction(SKAction.fadeOutWithDuration(1)) { () -> Void in
            label.removeFromParent()
            let time: Double = 1// - (0.1*Double(level))
            self.timer = NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: "addIcon", userInfo: nil, repeats: true)
        }
        
}
    
    func initControl(){
        analog = AnalogControl(scene: self)
        addChild(analog)
        
        jumpButton = ButtonControl(type: ButtonControl.buttonType.jumpButton, scene: self)
        addChild(jumpButton)
        
        hitButton = ButtonControl(type: ButtonControl.buttonType.hitButton, scene: self)
        addChild(hitButton)
    }
    
    func addIcon() {
        //let icon = Icon(scene: self,lastIconPositionX: lastIconPositionX)
        //icons.append(icon)
        //lastIconPositionX = icon.position.x
        //background.addChild(icon)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        switch (contact.bodyB.categoryBitMask) {
        
        case (PhysicsCategory.Player):
            if(contact.bodyA.categoryBitMask == PhysicsCategory.Enemy){ stick.getDamage(10) }
        
        
        
        case (PhysicsCategory.Fireball):
            switch (contact.bodyA.categoryBitMask) {
            case (PhysicsCategory.Background):
                
                contact.bodyB.node?.removeAllActions()
                contact.bodyB.node?.runAction(SKAction.fadeOutWithDuration(0.3)) { () -> Void in
                    contact.bodyB.node?.removeFromParent()
                }
                
            case (PhysicsCategory.Enemy):
                
                contact.bodyB.node?.removeAllActions()
                contact.bodyB.node?.runAction(SKAction.fadeOutWithDuration(0.1)) { () -> Void in
                    contact.bodyB.node?.removeFromParent()
                }
                
                contact.bodyA.node?.removeAllActions()
                contact.bodyA.node?.runAction(SKAction.fadeOutWithDuration(0.1)) { () -> Void in
                    contact.bodyA.node?.removeFromParent()
                }
                
            default:
                print("default")
            }
        
            
            
        case (PhysicsCategory.Background):
            print("Background ")
        
        
        
        case (PhysicsCategory.Enemy):
            switch (contact.bodyA.categoryBitMask) {
            case (PhysicsCategory.Player):
                
                stick.getDamage(10)
                
            case (PhysicsCategory.Fireball):
                
                contact.bodyB.node?.removeAllActions()
                contact.bodyB.node?.runAction(SKAction.fadeOutWithDuration(0.1)) { () -> Void in
                    contact.bodyB.node?.removeFromParent()
                }
                
                contact.bodyA.node?.removeAllActions()
                contact.bodyA.node?.runAction(SKAction.fadeOutWithDuration(0.1)) { () -> Void in
                    contact.bodyA.node?.removeFromParent()
                }
                
            default:
                print("default")
            }
        
            
        
        
        default:
            print("default")
        }

        
    }
    
    
    func gameOver(){
        self.removeChildrenInArray([analog, jumpButton, hitButton, hud])
        stick.stop()
        stick.runAction(SKAction.rotateByAngle(CGFloat(M_PI_2), duration: 0.3))
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = String("GAME OVER!")
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint (x: size.width/2, y: size.height/2)
        addChild(label)
        
        label.runAction(SKAction.fadeOutWithDuration(2)) { () -> Void in
            self.removeAllChildren()
            self.loadGame(self.level > 0 ? self.level-1 : 0)
        }

    }

}
