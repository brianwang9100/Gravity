//
//  Color.swift
//  Gravity
//
//  Created by Brian Wang on 7/23/16.
//  Copyright © 2016 Brian Wang. All rights reserved.
//

import Foundation
import SpriteKit

//https://en.wikipedia.org/wiki/Web_colors
let COLORS = [
//                UIColor.colorFromHex(0xFFFFFF),     //White
//                UIColor.colorFromHex(0xC0C0C0),     //Silver
//                UIColor.colorFromHex(0x808080),     //Gray
//                UIColor.colorFromHex(0x000000),     //Black
                UIColor.colorFromHex(0xFF0000),     //Red
                UIColor.colorFromHex(0x800000),     //Maroon
                UIColor.colorFromHex(0xFFFF00),     //Yellow
                UIColor.colorFromHex(0x808000),     //Olive
                UIColor.colorFromHex(0x00FF00),     //Lime
                UIColor.colorFromHex(0x008000),     //Green
                UIColor.colorFromHex(0x00FFFF),     //Aqua
                UIColor.colorFromHex(0x008080),     //Teal
                UIColor.colorFromHex(0x0000FF),     //Blue
                UIColor.colorFromHex(0x000080),     //Navy
                UIColor.colorFromHex(0xFF00FF),     //Fuchisa
                UIColor.colorFromHex(0x800080),]    //Purple

func randomColor() -> UIColor {
    let random = randomInt(lower: 0, upper: COLORS.count - 1)
    return COLORS[random]
}

                                                
class ColorManager {
    
}

class ColorGenerator {
    let stripSize:Int
    
    init(stripSize:Int) {
        self.stripSize = stripSize
    }
}

class TwoColorGenerator:ColorGenerator {
    var lowerColor:UIColor!
    var upperColor:UIColor!
    var colorStrip:[UIColor] = []
    var index = 0
    
    override init (stripSize:Int) {
        super.init(stripSize: stripSize)
        generateNewTwoColorSet()
    }
    
    func generateNextColor() -> UIColor {
        let color = colorStrip[index]
        index += 1
        if index >= colorStrip.count {
            index = 0
            generateNewTwoColorSet()
        }
        return color
    }
    
    func generateNewTwoColorSet() {
        lowerColor = upperColor ?? randomColor()
        upperColor = randomColor()
        colorStrip = []
        let componentDifference = UIColor.componentDifference(initial: lowerColor, final: upperColor)
        let deltaR = componentDifference.red / CGFloat(stripSize)
        let deltaG = componentDifference.green / CGFloat(stripSize)
        let deltaB = componentDifference.blue / CGFloat(stripSize)
        var lastColor:UIColor = lowerColor.copy() as! UIColor
        for _ in 1...stripSize {
            colorStrip.append(lastColor)
            let newColorComponenets = lastColor.components
            let newColor = UIColor(red: newColorComponenets.red + deltaR, green: newColorComponenets.green + deltaG, blue: newColorComponenets.blue + deltaB, alpha: newColorComponenets.alpha)
            lastColor = newColor
        }
    }
}
