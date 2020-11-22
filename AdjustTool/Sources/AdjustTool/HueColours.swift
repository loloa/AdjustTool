//
//  HueColours.swift
//  AdjustTool
//
//  Created by Lilia Lashin on 15/11/2020.
//

import Foundation
import UIKit

/*
 
 let red = CGFloat(0) // UIColor(red: 0.901961, green: 0.270588, blue: 0.270588, alpha: 1).hue()
 let orange = UIColor(red: 0.901961, green: 0.584314, blue: 0.270588, alpha: 1).hue()
 let yellow = UIColor(red: 0.901961, green: 0.901961, blue: 0.270588, alpha: 1).hue()
 let green = UIColor(red: 0.270588, green: 0.901961, blue: 0.270588, alpha: 1).hue()
 let aqua = UIColor(red: 0.270588, green: 0.901961, blue: 0.901961, alpha: 1).hue()
 let blue = UIColor(red: 0.270588, green: 0.270588, blue: 0.901961, alpha: 1).hue()
 let purple = UIColor(red: 0.584314, green: 0.270588, blue: 0.901961, alpha: 1).hue()
 let magenta = UIColor(red: 0.901961, green: 0.270588, blue: 0.901961, alpha: 1).hue()
 
 */

enum HueColor: Int {
    
    case red = 1, orange = 2, yellow = 3, green = 4, blue = 5, magenta = 6
    
    var colour: UIColor {
        
        switch self {
        case .red:
            return UIColor.red
         case .orange:
            return UIColor(red: 0.901961, green: 0.584314, blue: 0.270588, alpha: 1)  //UIColor.orange
        case .yellow:
            return UIColor(red: 0.901961, green: 0.901961, blue: 0.270588, alpha: 1)//UIColor.yellow
        case .green:
            return UIColor(red: 0.270588, green: 0.901961, blue: 0.270588, alpha: 1)//UIColor.green
        case .blue:
            return UIColor(red: 0.270588, green: 0.270588, blue: 0.901961, alpha: 1)//UIColor.blue
        case .magenta:
            return UIColor(red: 0.901961, green: 0.270588, blue: 0.901961, alpha: 1)
         }
    }
    
    var colourWithHue: UIColor {
         return UIColor(hue: CGFloat(self.midSpecotor), saturation: CGFloat(1), brightness: CGFloat(0), alpha: CGFloat(1))
    }
    
    //
    
    var minSpecotor : Float {
        
        // slider 0 - 100 , 0-1
        let step: CGFloat = 100 / 360
        switch self {
        case .red:
            return Float((-15 * step) / 100)
         case .orange:
            return Float((20 * step) / 100)
        case .yellow:
            return Float((45 * step) / 100)
        case .green:
            return Float((90 * step) / 100)
        case .blue:
            return Float((200 * step) / 100)
        case .magenta:
            return Float((240 * step) / 100)
         }
    }
    
    var maxSpecotor : Float {
        
        // slider 0 - 100 , 0-1
        let step: CGFloat = 100 / 360
        switch self {
        case .red:
            return Float((15 * step) / 100)
         case .orange:
            return Float((40 * step) / 100)
        case .yellow:
            return Float((75 * step) / 100)
        case .green:
            return Float((150 * step) / 100)
        case .blue:
            return Float((280 * step) / 100)
        case .magenta:
            return Float((300 * step) / 100)
         }
    }
    
    var midSpecotor : Float {
        
        // slider 0 - 100 , 0-1
        let step: CGFloat = 100 / 360
        switch self {
        case .red:
            return Float((0 * step) / 100)
         case .orange:
            return Float((30 * step) / 100)
        case .yellow:
            return Float((60 * step) / 100)
        case .green:
            return Float((120 * step) / 100)
        case .blue:
            return Float((240 * step) / 100)
        case .magenta:
            return Float((270 * step) / 100)
         }
    }
    
}
