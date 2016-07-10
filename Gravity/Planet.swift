//
//  Planet.swift
//  GravityWave
//
//  Created by Brian Wang on 6/22/16.
//  Copyright © 2016 Brian Wang. All rights reserved.
//

import UIKit
import SpriteKit

class Planet: SKShapeNode, GravityObject {
    var radius:CGFloat = 0
    var entryDirection:PlanetDirection!
    var exitDirection:PlanetDirection!
    var previousPlanet:Planet!
    var nextPlanet:Planet!
    var vectorFromPrev:CGPoint!
    var distanceBetweenPlayer:CGFloat = 0
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
