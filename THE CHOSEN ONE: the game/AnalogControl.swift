//
//  AnalogControl.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 17.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import UIKit
import SpriteKit

class AnalogControl: SKSpriteNode {
    
    var myScene : GameScene!
    
    var analogStick: SKSpriteNode!
    
    init(scene: GameScene!) {
        myScene = scene
        super.init(texture: SKTexture(imageNamed: "Analog_Background_Image"), color: UIColor.clearColor(), size: CGSize(width: 100, height: 100))
        self.position = CGPoint(x: 70, y: 70)
        self.alpha = 0.8
        userInteractionEnabled = true;
        
        analogStick = SKSpriteNode(texture: SKTexture(imageNamed: "Analog_Stick_Image"), size: CGSize(width: 100, height: 100))
        addChild(analogStick)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - Overrides
    internal override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    internal override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesMoved(touches, withEvent: event);
        
        for touch: AnyObject in touches {
            
            var location = touch.locationInNode(self);
            
            if(sqrt(pow(location.x, 2) + pow(location.y, 2)) > 40){
                let k = sqrt(pow(location.x, 2) + pow(location.y, 2))/40
                location.x/=k
                location.y/=k
            }
            
            analogStick.position = location
            
            myScene.stick.move(location.x)
            
            
            
        }
    }
    
    internal override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesEnded(touches, withEvent: event)
        resetStick()
    }
    
    internal override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        super.touchesCancelled(touches, withEvent: event)
        resetStick()
    }

    func resetStick(){
        analogStick.runAction(SKAction.moveTo(CGPoint(x: 0, y: 0), duration: 0.1))
        myScene.stick.stop()
    }


}
