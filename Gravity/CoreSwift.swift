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
///returns trus if the current device is an iPad
func iPad() -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
}

///returns trus if the current device is an iPhone 4S
func is4S() -> Bool {
    return UIScreen.mainScreen().bounds.height == 480.0
}


func randomInt(lower lower:CGFloat, upper:CGFloat) -> CGFloat {
    return CGFloat(randomInt(lower: Int(lower), upper: Int(upper)))
}

func randomInt(lower lower:Int, upper:Int) -> Int {
    return Int(arc4random_uniform(UInt32(upper - lower + 1))) + Int(lower)
}

func synced(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}


enum GradientDirection {
    case Up
    case Left
    case UpLeft
    case UpRight
}

extension SKTexture {
    convenience init(size:CGSize,color1:CIColor,color2:CIColor,direction:GradientDirection = .Up) {
        let coreImageContext = CIContext(options: nil)
        let gradientFilter = CIFilter(name: "CILinearGradient")!
        gradientFilter.setDefaults()
        var startVector:CIVector
        var endVector:CIVector
        switch direction {
        case .Up:
            startVector = CIVector(x: size.width/2, y: 0)
            endVector = CIVector(x: size.width/2, y: size.height)
        case .Left:
            startVector = CIVector(x: size.width, y: size.height/2)
            endVector = CIVector(x: 0, y: size.height/2)
        case .UpLeft:
            startVector = CIVector(x: size.width, y: 0)
            endVector = CIVector(x: 0, y: size.height)
        case .UpRight:
            startVector = CIVector(x: 0, y: 0)
            endVector = CIVector(x: size.width, y: size.height)
            
        }
        gradientFilter.setValue(startVector, forKey: "inputPoint0")
        gradientFilter.setValue(endVector, forKey: "inputPoint1")
        gradientFilter.setValue(color1, forKey: "inputColor0")
        gradientFilter.setValue(color2, forKey: "inputColor1")
        let cgimg = coreImageContext.createCGImage(gradientFilter.outputImage!, fromRect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.init(CGImage:cgimg)
    }
    
    convenience init(radius:CGFloat, color:UIColor = UIColor.whiteColor()) {
        let twoRadius = radius * 2
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(twoRadius, twoRadius), false, 0)
        color.set()
        let p = UIBezierPath(ovalInRect: CGRectMake(0, 0, twoRadius, twoRadius))
        p.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(image: image)
    }
}