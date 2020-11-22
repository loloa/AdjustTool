//
//  AdjustTollsKit+Convert.swift
//  AdjustTool
//
//  Created by Lilia Lashin on 22/11/2020.
//

import Foundation
import UIKit

extension AdjustToolsKit {
    
static func convert(value: Float, for editAction: AdjustActionType, heu: HueColor? = nil) -> Int {
    //static func convert(value: Float, for editAction: AdjustActionType, heu: HueColor? = nil) -> Float {
        
        let tupel = AdjustToolsKit().configureSliderValues(for: editAction, hue: heu)
        
        if value == tupel.startValue {
            return 0
        }
        if value > tupel.startValue {
            let v = ((value - tupel.startValue) * 100.0) / (tupel.max - tupel.startValue)
            return Int(v)
        }
        
        if value >= 0 && value < tupel.startValue {
            
            if (tupel.startValue != tupel.max ) {
                let step = -100.0 / (tupel.startValue - tupel.max)
                let v = (value - tupel.startValue) * step
                return Int(v)
            } else {
               // heightlits
                let v = (value - 1) * 100.0 / (tupel.max - tupel.min)
                return Int(v)
            }
               
        }
        if value < 0 && value < tupel.startValue {
           // return value * 100.0 / (tupel.max - tupel.startValue)
            let step = -100.0 / (tupel.startValue - tupel.max)
            let v = (value - tupel.startValue) * step
            return Int(v)
        }
        
        return Int(value)
        
        
//
//        if tupel.startValue == 0.0 {
//            let v = Int((value * 100) / tupel.max)
//            return v
//        } else if tupel.startValue > 0.0 {
//            let v = Int((value * 100) / (tupel.max - tupel.startValue))
//            return v
//        } else {
//            let v = Int((value * 100) / ( tupel.startValue - tupel.max))
//            return v
//        }
    }
}
