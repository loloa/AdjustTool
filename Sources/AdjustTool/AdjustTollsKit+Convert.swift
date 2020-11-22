//
//  AdjustTollsKit+Convert.swift
//  AdjustTool
//
//  Created by Lilia Lashin on 22/11/2020.
//

import Foundation

extension AdjustToolsKit {
   
    func testfunction(){
        //print
        var a = 10
        
     }
    
    // dont know how to convert
   // static func convert(value: Float, for editAction: AdjustActionType, heu: HueColor? = nil) -> Int {
    static func convert(value: Float, for editAction: AdjustActionType, heu: HueColor? = nil) -> Float {
        return value
        
//        let tupel = AdjustToolsKit().configureSliderValues(for: editAction, hue: heu)
//        
//        if tupel.min == 0.0 {
//            return Int(value * 100 / tupel.max)
//        }
//        
//        if value == tupel.startValue {
//            return 0
//        }
//        if value > tupel.startValue {
//            return Int(((value - tupel.startValue) * 100) / (tupel.max - tupel.startValue))
//        }
//        
//        if value < tupel.startValue {
//            return Int(((tupel.startValue - value) * 100) / tupel.min - tupel.startValue)
//        }
//        
//        return Int(value)
        
        
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
