//
//  AdjustTollsLibrary.swift
//  PhotoScanner
//
//  Created by Lilia Lashin on 08/11/2020.
//  Copyright © 2020 Lilia Lashin. All rights reserved.
//

import Foundation
import UIKit


typealias SliderConfiguration = (min: Float, max: Float, startValue: Float, valueName: String)

struct HSLDataModel {
    var lastShiftHueValue: CGFloat?
    var lastSaturationHueValue: CGFloat?
    var lastLuminanceValue: CGFloat?
}


class AdjustToolsKit {
 
   private lazy var context: CIContext = {
        return CIContext(options:nil)
    }()
    
   internal lazy var hslDataMode = {
        return HSLDataModel()
    }()
    
    // MARK: - APPLY
    
    typealias toolKitComplition = ( _ img: UIImage,  _ userInfo: [AnyHashable: Any]?) -> Void
    
     func applyAdjustTool(uiImage: UIImage, withAmount intensity: Float, type: AdjustActionType?, hueColor: HueColor? = nil, complition: @escaping toolKitComplition) {
        
        guard let editType = type,
              let img = CIImage(image: uiImage) else {
            complition(uiImage, nil)
            return
        }
        
        var ciImage: CIImage?
        
        switch editType {
        case .Exposure:
            ciImage = exposureFilter(img: img, withAmount: intensity)
        case .Contrast:
            ciImage = contrastFilter(img: img, withAmount: intensity)
        case .Saturation:
            ciImage = saturationFilter(img: img, withAmount: intensity)
        case .Vignette:
            ciImage = vignetteFilter(img: img, withAmount: intensity)
        case .Tint:
            ciImage = tintFilter(img: img, withAmount: intensity)
        case .Temperature:
            ciImage = temperatureFilter(img: img, withAmount: intensity)
        case .Grain:
             ciImage = grainFilter(img: img, withAmount: intensity)
         case .Shadow:
            ciImage = shadowFilter(img: img, withAmount: intensity)
        case .Highlights:
            ciImage = highlightFilter(img: img, withAmount: intensity)
        case .Sharpness:
            ciImage = sharpnessFilter(img: img, withAmount: intensity)
        case .HueSkinTone:
            ciImage = skinToneFilter(img: img, withAmount: intensity)
        case .Vibrance:
            ciImage = vibranceFilter(img: img, withAmount: intensity)
        case .Fade:
            ciImage = fadeFilter(img: img, withAmount: intensity)
        case .Colored:
            //not in use
            ciImage = coloredFilter(img: img, withAmount: intensity, color: UIColor.purple)
        case .Brightness:
            ciImage = brightnessFilter(img: img, withAmount: intensity)
        case .HSL_Hue:
            ciImage = HSLHueFilter(img: img, withAmount: intensity, hueColour: hueColor)
        case .HSL_Saturation:
            ciImage = HSLSaturationFilter(img: img, withAmount: intensity, hueColour: hueColor)
        case .HSL_Luminance:
            ciImage = HSLLuminenceFilter(img: img, withAmount: intensity, hueColour: hueColor)
         default:
            break
        }
        
        guard let outputImage = ciImage,
              let cgImage = context.createCGImage(outputImage, from:img.extent) else {
            complition(uiImage, nil)
            return
        }
        
        let newImage = UIImage(cgImage: cgImage, scale:1, orientation: uiImage.imageOrientation)
        complition(newImage, nil)
    }
 
   
}
