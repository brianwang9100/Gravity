//
//  Enums.swift
//  Gravity
//
//  Created by Brian Wang on 6/29/16.
//  Copyright © 2016 Brian Wang. All rights reserved.
//

import Foundation
import SpriteKit

enum PlanetDirection : CGFloat { // 0 is north, 180 is south,
    case North = 0.0
    case South = 1.0
    case East  = 0.5
    case West  = 1.5
    case NorthEast = 0.25
    case SouthEast = 0.75
    case SouthWest = 1.25
    case NorthWest = 1.75
    
    func oppositeDirection() -> PlanetDirection {
        if self.rawValue >= 1.0 {
            return PlanetDirection(rawValue: self.rawValue - 1.0)!
        } else {
            return PlanetDirection(rawValue: self.rawValue + 1.0)!
        }
    }
    
    func toPi() -> CGFloat {
        return self.rawValue * pi
    }
    
    func toDeg() -> CGFloat {
        return self.rawValue * 360.0
    }
    
    func randomExitDirection() -> PlanetDirection {
        let entry = self.rawValue
        var start = entry + 0.5
        let upperBound:CGFloat = 100
        let percentages:[CGFloat] = [0.0, 0.20, 0.50, 0.20, 0.0]
        let random = randomInt(lower: 1, upper: upperBound)
        var i = 0
        var p:CGFloat = 0
        while (random >= p * upperBound && i < percentages.count - 1) {
            i += 1
            p += percentages[i]
            start += 0.25
        }
        return PlanetDirection(rawValue: start % 2)!
    }
}

enum RotationDirection {
    case Clock, CounterClock
    
    func opposite() -> RotationDirection {
        if self == .Clock {
            return .CounterClock
        } else {
            return .Clock
        }
    }
}

enum Quadrant {
    case TR, BR, BL, TL, None
    
    static func quadrant(value:CGFloat) -> Quadrant {
        if value >= 0 && value < 0.5 {
            return Quadrant.TR
        } else if value >= 0.5 && value < 1 {
            return Quadrant.BR
        } else if value >= 1 && value < 1.5 {
            return Quadrant.BL
        } else if value >= 1.5 && value < 2 {
            return Quadrant.TL
        }
        return .None
    }
}
