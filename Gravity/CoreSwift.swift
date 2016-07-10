//
//  CoreSwift.swift
//  GravityWave
//
//  Created by Brian Wang on 6/26/16.
//  Copyright © 2016 Brian Wang. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

infix operator ^^ { associativity left precedence 160 }
func ^^ (radix: CGFloat, power: CGFloat) -> CGFloat {
    return pow(CGFloat(radix), CGFloat(power))
}

func randomInt(lower lower:CGFloat, upper:CGFloat) -> CGFloat {
    return CGFloat(Int(arc4random_uniform(UInt32(upper - lower + 1))) + Int(lower))
}

func synced(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}