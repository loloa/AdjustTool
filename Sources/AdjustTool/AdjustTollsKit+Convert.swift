//
//  AdjustTollsKit+Convert.swift
//  AdjustTool
//
//  Created by Lilia Lashin on 22/11/2020.
//

import Foundation
import UIKit

@available(iOS 10.0, *)
extension AdjustToolsKit {
    
public static func convert(value: Float, for editAction: AdjustActionType, heu: HueColor? = nil) -> Int {
 
    let tupel = AdjustToolsKit().configureTool(for: editAction, hue: heu)
  
    if value == tupel.startValue { return 0 }
    if value == tupel.max { return 100 }
    if value == tupel.min { return -100 }
 
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
   
    }
    
    
    static func resizeImageIfNeeded(_ imgCrop: UIImage, withSize: CGFloat) -> UIImage {
        var tempImg = imgCrop
        let maximum = max(tempImg.size.width, tempImg.size.height)
        if maximum > withSize {
            let ratio = min(tempImg.size.width,imgCrop.size.height) / max(tempImg.size.width, tempImg.size.height)
            if tempImg.size.width > tempImg.size.height {
                if let image  = AdjustToolsKit.resizeImage(image: tempImg, targetSize: CGSize(width: withSize, height: withSize * ratio)) {
                    tempImg = image
                }
            } else {
                if let image  = AdjustToolsKit.resizeImage(image: tempImg, targetSize: CGSize(width: withSize * ratio, height: withSize)) {
                    tempImg = image
                }
            }
        }
        return tempImg
    }
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        
        let scale = targetSize.width / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: targetSize.width, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
