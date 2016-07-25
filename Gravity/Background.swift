//
//  Background.swift
//  Gravity
//
//  Created by Brian Wang on 7/14/16.
//  Copyright © 2016 Brian Wang. All rights reserved.
//

import Foundation
import SpriteKit

class Background:SKSpriteNode {
    var gradientSprite:SKSpriteNode? {
        willSet(newSprite) {
            gradientSprite?.removeFromParent()
            self.addChild(newSprite!)
        }
    }
    var colorSprite:SKSpriteNode? {
        willSet(newSprite) {
            colorSprite?.removeFromParent()
            self.addChild(newSprite!)
        }
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    func setup() {
        let size = CGSizeMake(800, 800)
        
        let color1 = CIColor(color: UIColor.darkGrayColor())
        let color2 = CIColor(color: UIColor.blackColor())
        let gradientTexture = SKTexture(size: size, color1: color1, color2: color2, direction: .Up)
        let bgGradient = SKSpriteNode(texture: gradientTexture)
        bgGradient.position = CGPointMake(0, 0)
        bgGradient.anchorPoint = CGPointMake(0.5, 0.5)
        bgGradient.zPosition = 1
        
        let rotationAnimation = SKAction.rotateByAngle(10, duration: 20)
        let rotationAnimationForever = SKAction.repeatActionForever(rotationAnimation)
        bgGradient.runAction(rotationAnimationForever)
        
        let color3 = CIColor(color: UIColor.blackColor())
        let color4 = CIColor(color: UIColor.darkGrayColor())
        let colorTexture = SKTexture(size: size, color1: color3, color2: color4, direction: .Up)
        let bgColor = SKSpriteNode(texture: colorTexture)
        bgColor.position = CGPointMake(0, 0)
        bgColor.anchorPoint = CGPointMake(0.5, 0.5)
        bgColor.zPosition = 2
        bgColor.blendMode = .Multiply
        
        let reversedRotationAnimation = rotationAnimation.reversedAction()
        let reversedRotationAnimationForever = SKAction.repeatActionForever(reversedRotationAnimation)
        bgColor.runAction(reversedRotationAnimationForever)
        
        self.gradientSprite = bgGradient
        self.colorSprite = bgColor
        bgGradient.lightingBitMask = 1
        bgGradient.shadowedBitMask = 1
//        bgGradient.shadowCastBitMask = 1
        bgColor.lightingBitMask = 1
        bgColor.shadowedBitMask = 1
//        bgColor.shadowCastBitMask = 1
//        self.lightingBitMask = 1
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}