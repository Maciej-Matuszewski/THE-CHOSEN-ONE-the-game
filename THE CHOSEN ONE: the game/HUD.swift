//
//  HUD.swift
//  THE CHOSEN ONE: the game
//
//  Created by Maciej Matuszewski on 18.11.2015.
//  Copyright © 2015 Maciej Matuszewski. All rights reserved.
//

import UIKit
import SpriteKit

class HUD: SKSpriteNode {
    
    var heartOne : SKSpriteNode!
    var heartTwo : SKSpriteNode!
    var heartThree : SKSpriteNode!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(scene: GameScene!) {

        super.init(texture: SKTexture(imageNamed: "HUD_Background_Image"), color: UIColor.redColor(), size: CGSize(width: 300, height: 100))
        position = CGPoint(x: 150, y: scene.size.height-50)
        
        heartOne = SKSpriteNode(imageNamed: "heart")
        heartOne.size = CGSize(width: 30, height: 30)
        heartOne.position = CGPoint(x: -40, y: 25)
        self.addChild(heartOne)
        
        heartTwo = SKSpriteNode(imageNamed: "heart")
        heartTwo.size = CGSize(width: 30, height: 30)
        heartTwo.position = CGPoint(x: 0, y: 25)
        self.addChild(heartTwo)
        
        heartThree = SKSpriteNode(imageNamed: "heart")
        heartThree.size = CGSize(width: 30, height: 30)
        heartThree.position = CGPoint(x: +40, y: 25)
        self.addChild(heartThree)
        
    }
    
    func updateHUD(health : Int){
        
        if(health == 100){
            heartOne.alpha = 1.0
            heartTwo.alpha = 1.0
            heartThree.alpha = 1.0
        }else if(health >= 90){
            heartOne.alpha = 1.0
            heartTwo.alpha = 1.0
            heartThree.alpha = 0.5
        }else if(health >= 70){
            heartOne.alpha = 1.0
            heartTwo.alpha = 1.0
            heartThree.alpha = 0.0
        }else if(health >= 50){
            heartOne.alpha = 1.0
            heartTwo.alpha = 0.5
            heartThree.alpha = 0.0
        }else if(health >= 30){
            heartOne.alpha = 1.0
            heartTwo.alpha = 0.0
            heartThree.alpha = 0.0
        }else if(health >= 10){
            heartOne.alpha = 0.5
            heartTwo.alpha = 0.0
            heartThree.alpha = 0.0
        }else{
            heartOne.alpha = 0.0
            heartTwo.alpha = 0.0
            heartThree.alpha = 0.0
        }
        
    }
    
}
