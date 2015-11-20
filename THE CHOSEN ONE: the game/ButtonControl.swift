//
//  ButtonControl.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 17.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import UIKit
import SpriteKit

class ButtonControl: SKSpriteNode {
    
    enum buttonType : Int {
        case jumpButton = 1
        case hitButton = 2
    }
    
    var type: buttonType!
    var myScene : GameScene!
    
    init(type : buttonType!, scene:GameScene!) {
        myScene = scene
        self.type = type
        
        var texture : SKTexture!
        var startPosition : CGPoint
        
        if(type == buttonType.jumpButton){
            startPosition = CGPoint(x: myScene.size.width-110, y: 55)
            texture = SKTexture(imageNamed: "buttonA")
        }else if(type == buttonType.hitButton){
            startPosition = CGPoint(x: myScene.size.width-55, y: 110)
            texture = SKTexture(imageNamed: "buttonB")
        }else{
            startPosition = CGPoint(x:0, y: 0)
            texture = SKTexture(imageNamed: "ut")
        }
        
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: 80, height: 80))
        self.position = startPosition
        self.alpha = 0.7
        
        userInteractionEnabled = true;
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overrides
    internal override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesBegan(touches, withEvent: event)
        
        if(self.type == buttonType.jumpButton){
            myScene.stick.jump()
            self.texture = SKTexture(imageNamed: "buttonA_push")
        }else if(self.type == buttonType.hitButton){
            myScene.stick.hit()
            self.texture = SKTexture(imageNamed: "buttonB_push")
        }
        
    }
    
    internal override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesEnded(touches, withEvent: event)
        
        if(self.type == buttonType.jumpButton){
            self.texture = SKTexture(imageNamed: "buttonA")
        }else if(self.type == buttonType.hitButton){
            self.texture = SKTexture(imageNamed: "buttonB")
        }
    }
    
    internal override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        super.touchesCancelled(touches, withEvent: event)
        
        if(self.type == buttonType.jumpButton){
            self.texture = SKTexture(imageNamed: "buttonA")
        }else if(self.type == buttonType.hitButton){
            self.texture = SKTexture(imageNamed: "buttonB")
        }
    }

    
}
