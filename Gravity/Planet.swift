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
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        let color = planetColorGenerator.generateNextColor()
        let colors = [color, color, color, UIColor.whiteColor()]
        let gradientNode = BDGradientNode(radialGradientWithTexture: whiteTexture, colors: colors, locations: nil, firstCenter: CGPointMake(0.5 , 0.5), firstRadius: 0, secondCenter: CGPointMake(0.5, 0.5), secondRadius: 0.5, blending: 0.5, discardOutsideGradient: true, keepTextureShape: false, size: CGSizeMake(2*radius, 2*radius))
        gradientNode.position = CGPointMake(0, 0)
        gradientNode.anchorPoint = CGPointMake(0.5, 0.5)
        gradientNode.zPosition = 100
//        gradientNode.blendMode = .Alpha
        self.addChild(gradientNode)
    }
}
