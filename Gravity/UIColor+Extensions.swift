//
//  UIColor+Extensions.swift
//  Gravity
//
//  Created by Brian Wang on 7/24/16.
//  Copyright © 2016 Brian Wang. All rights reserved.
//

import Foundation
import SpriteKit

extension UIColor {
    static func colorFromHex(hex: Int) -> UIColor {
        return UIColor.init(red: CGFloat(Double((hex & 0xFF0000) >> 16)/255.0), green: CGFloat(Double((hex & 0x00FF00) >> 8)/255.0), blue: CGFloat(Double((hex & 0x0000FF) >> 0)/255.0), alpha: 1.0)
    }
    
    static func colorFromR(redR: CGFloat, greenR: CGFloat, blueR: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: redR/255.0, green: greenR/255.0, blue: blueR/255.0, alpha: alpha)
    }
    
    var components:(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat, redR:CGFloat, greenR:CGFloat, blueR:CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a, r*255.0, g*255.0, b*255.0)
    }
    
    static func componentDifference(initial initial:UIColor, final:UIColor) -> (red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat, redR:CGFloat, greenR:CGFloat, blueR:CGFloat) {
        let initialComp = initial.components
        let finalComp = final.components
        let r = finalComp.red - initialComp.red
        let g = finalComp.green - initialComp.green
        let b = finalComp.blue - initialComp.blue
        let a = finalComp.alpha
        return (r,g,b,a, r*255.0, g*255.0, b*255.0)
    }
    
    func colorWithShadeOffset(offset: CGFloat, R: Bool) -> UIColor {
        let comp = self.components
        if R {
            let r = comp.redR + offset
            let g = comp.greenR + offset
            let b = comp.blueR + offset
            let a = comp.alpha + offset
            return UIColor.colorFromR(r, greenR: g, blueR: b, alpha: a)
        }
        let r = comp.red + offset
        let g = comp.green + offset
        let b = comp.blue + offset
        let a = comp.alpha + offset
        return UIColor(red: r, green: g, blue: b, alpha: a)
        
    }
    
}

//public func + (left: UIColor, right: UIColor) -> UIColor {
//    let leftcomp = left.components
//    let rightcomp = right.components
//    let red = leftcomp.red + rightcomp.red
//    let green = leftcomp.green + rightcomp.green
//    let blue = leftcomp.blue + rightcomp.blue
//    let alpha = leftcomp.alpha + rightcomp.alpha
//    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
//}
//
//public func - (left: UIColor, right: UIColor) -> UIColor {
//    
//}

