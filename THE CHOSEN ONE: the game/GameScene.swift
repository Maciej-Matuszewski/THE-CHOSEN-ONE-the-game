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
    
    var lastHit : NSDate!
    
    var lastIconPositionX : CGFloat!
    
    struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Background : UInt32 = 1
        static let Player   : UInt32 = 2
        static let Fireball : UInt32 = 8
        static let Icons : UInt32 = 16
        
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
        
        lastHit = NSDate()
        
        background = Background(scene: self)
        addChild(background)
        
        
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
            let time: Double = 4// - (0.1*Double(level))
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
        let icon = Icon(scene: self,lastIconPositionX: lastIconPositionX)
        icons.append(icon)
        lastIconPositionX = icon.position.x
        background.addChild(icon)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        switch (contact.bodyB.categoryBitMask) {
        case (PhysicsCategory.Player):
            print("Player ")
        case (PhysicsCategory.Fireball):
            print("Fireball ")
        case (PhysicsCategory.Background):
            print("Background ")
        case (PhysicsCategory.Icons):
            print("Icons ")
        default:
            print("default")
        }

/*
        
        switch (contact.bodyA.categoryBitMask) {
            
        case (PhysicsCategory.Background):
            
            switch (contact.bodyB.categoryBitMask) {
            case (PhysicsCategory.Fireball):
                
                contact.bodyB.node?.removeAllActions()
                contact.bodyB.node?.runAction(SKAction.fadeOutWithDuration(0.3)) { () -> Void in
                        contact.bodyB.node?.removeFromParent()
                }
                
            case (PhysicsCategory.Background):
                print("Background ")
            case (PhysicsCategory.Icons):
                print("Icons ")
            default:
                break
            }
            
            break
            
            
        case (PhysicsCategory.Player):
            print("\(NSDate()) - Player: ")
        case (PhysicsCategory.Fireball):
            print("\(NSDate()) - Fireball: ")
        case (PhysicsCategory.Icons):
            print("\(NSDate()) - Icons: ")
        default:
            print("\(NSDate()) - default")
        }
        
        /*
        switch (contact.bodyB.categoryBitMask) {
        case (PhysicsCategory.Player):
            print("Player ")
        case (PhysicsCategory.Fireball):
            print("Fireball ")
        case (PhysicsCategory.Background):
            print("Background ")
        case (PhysicsCategory.Icons):
            print("Icons ")
        default:
            print("default")
        }

*/
        
    }
    
    
    /*
    func didBeginContact(contact: SKPhysicsContact) {
        
        let components:NSDateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: lastHit, toDate: NSDate(), options: NSCalendarOptions.init(rawValue: 0))
        if(components.second > 1){
            
            lastHit = NSDate()
            
            for icon:Icon in icons{
                icon.removeFromParent()
            }
            
            
            
            if(hud.heartThree.hidden == false){
                hud.heartThree.hidden = true
            }else if(hud.heartTwo.hidden == false){
                hud.heartTwo.hidden = true
            }else if(hud.heartOne.hidden == false){
                hud.heartOne.hidden = true
            }else{
                timer.invalidate()
                stick.physicsBody?.dynamic = true
                stick.runAction(SKAction.fadeOutWithDuration(0.2))
                analog.hidden = true
                jumpButton.hidden = true
                hitButton.hidden = true
                contact.bodyA.dynamic = true
                
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

        
        
    }
*/

}
