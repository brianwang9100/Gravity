//
//  Player.swift
//  GravityWave
//
//  Created by Brian Wang on 6/26/16.
//  Copyright © 2016 Brian Wang. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKShapeNode {
    var radius:CGFloat = 0
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}