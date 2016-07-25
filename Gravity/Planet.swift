//
//  Planet.swift
//  GravityWave
//
//  Created by Brian Wang on 6/22/16.
//  Copyright © 2016 Brian Wang. All rights reserved.
//

import UIKit
import SpriteKit

class Planet: SKShapeNode {
    var radius:CGFloat = 0
    var entryDirection:PlanetDirection!
    var exitDirection:PlanetDirection!
    var previousPlanet:Planet!
    var nextPlanet:Planet!
    var vectorFromPrev:CGPoint!
    var distanceBetweenPlayer:CGFloat = 0
    var gradientNode:BDGradientNode!
    var lightNode:SKLightNode!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        //gradient
        let color = planetColorGenerator.generateNextColor()
        let colors = [color.colorWithShadeOffset(50, R: true),
                      color.colorWithShadeOffset(30, R: true),
                      color.colorWithShadeOffset(10, R: true),
                      color, color, UIColor.whiteColor()]
        gradientNode = BDGradientNode(radialGradientWithTexture: whiteTexture, colors: colors, locations: nil, firstCenter: CGPointMake(0.5 , 0.5), firstRadius: 0, secondCenter: CGPointMake(0.5, 0.5), secondRadius: 0.5, blending: 0.5, discardOutsideGradient: true, keepTextureShape: false, size: CGSizeMake(2*radius, 2*radius))
        gradientNode.position = CGPointMake(0, 0)
        gradientNode.anchorPoint = CGPointMake(0.5, 0.5)
        gradientNode.lightingBitMask = 1
        self.addChild(gradientNode)
        
        //light node
        lightNode = SKLightNode()
        lightNode.enabled = true
        lightNode.categoryBitMask = 1
        lightNode.lightColor = color
        lightNode.ambientColor = UIColor.darkGrayColor()
        lightNode.shadowColor = UIColor.blackColor()
        lightNode.falloff = 0.75
        lightNode.zPosition = 100
        self.addChild(lightNode)
        
        //self
        self.strokeColor = UIColor.clearColor()
        self.glowWidth = GLOW_WIDTH
        
        //fade animation
        gradientNode.alpha = 0
        lightNode.alpha = 0
        let fadeAction = SKAction.fadeAlphaTo(1, duration: 2)
        gradientNode.runAction(fadeAction)
        lightNode.runAction(fadeAction)
    }
}
