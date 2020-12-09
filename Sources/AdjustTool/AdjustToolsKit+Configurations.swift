//
//  AdjustToolsKit+Configurations.swift
//  AdjustTool
//
//  Created by Lilia Lashin on 19/11/2020.
//

import Foundation
import UIKit

@available(iOS 10.0, *)
extension AdjustToolsKit {
    
    public func configureTool(for editAction: AdjustActionType?, hue: HueColor? = nil) -> AdjustToolConfiguration {
        
        var tupel = AdjustToolConfiguration(min: Float(0), max: Float(0), startValue: Float(0), valueName: "", zoomRecomended: false, composed: false)
        guard let editType = editAction else { return tupel }
        
        switch editType {
        case .Exposure:
            /*
             ###################################### Filter name CIExposureAdjust
             CIAttributeDescription = "The amount to adjust the exposure of the image by. The larger the value, the brighter the exposure.";
             
             -- # Filter display name : EV
             -- # Filter default value : 0
             -- # Filter min slider value : -10.0
             -- # Filter max slider value : 10.0
             */
            tupel.min = -1.7
            tupel.max = 1.7
            tupel.startValue = 0.0
            tupel.valueName = "EV"
       
        case .Fade:
            
            tupel.min = 1.0
            tupel.max = 1.2
            tupel.startValue = 1.0
            tupel.valueName = "contrast"
        case .Contrast:
            
            /*
             ###################################### Filter name CIColorControls
             
             CIAttributeDescription = "The contrast of the light rays emanating from the flash.";
             -- # Filter display name : Contrast
             -- # Filter default value : 1
             -- # Filter min slider value : 0.25
             -- # Filter max slider value : 4.0
             */
            tupel.min = 0.9
            tupel.max = 1.1
            tupel.startValue = 1.0
            tupel.valueName = "contrast"
            
        case .Saturation:
            
            /*
             ###################################### Filter name CIColorControls
             
             CIAttributeDescription = "The amount to adjust the saturation."
             -- # Filter display name : Saturation
             -- # Filter default value : 1
             -- # Filter min slider value : 0.0
             -- # Filter max slider value : 2.0
             */
            
            tupel.min = 0.0
            tupel.max = 2.0
            tupel.startValue = 1.0
            tupel.valueName = "saturation"
            
        case .Vignette:
            
            /*
             ###################################### Filter name CIVignette
             
             -- # Filter display name : Intensity
             -- # Filter default value : 0
             -- # Filter min slider value : -1.0
             -- # Filter max slider value : 1.0
             
             CIAttributeDescription = "The distance from the center of the effect.";
             -- # Filter display name : Radius
             -- # Filter default value : 1
             -- # Filter min slider value : 0.0
             -- # Filter max slider value : 2.0
             */
            tupel.min = -2.5
            tupel.max = 2.5
            tupel.startValue = 0.0
            tupel.valueName = "intensity"
            
        case .Temperature:
            /*
             ###################################### Filter name CITemperatureAndTint
             
             -- # Filter display name : Neutral
             -- # Filter default value : [6500 0]
             -- # Filter min slider value : 0.0
             -- # Filter max slider value : 0.0
             */
            
            //https://ru.wikipedia.org/wiki/Цветовая_температура
            
            tupel.min = 4500.0 // -1
            tupel.max = 8500.0
            tupel.startValue = 6500.0
            tupel.valueName = "kelvins v x"
            
        case .Tint:
            /*
             ###################################### Filter name CITemperatureAndTint
             
             -- # Filter display name : Neutral
             -- # Filter default value : [6500 0]
             -- # Filter min slider value : 0.0
             -- # Filter max slider value : 0.0
             */
            tupel.min = -50.0 // -1
            tupel.max = 50.0
            tupel.startValue = 0.0
            tupel.valueName = "tint v y"
            
        case .Grain:
            
            tupel.min = 0.0 // -1
            tupel.max = 1.0
            tupel.startValue = 0.0
            tupel.valueName = "alpha"
            tupel.zoomRecomended = true
            
        case .Shadow:
            /*
             ###################################### Filter name CIHighlightShadowAdjust
             
             CIAttributeDescription = "Shadow Highlight Radius";
             -- # Filter display name : Radius
             -- # Filter default value : 0
             -- # Filter min slider value : 0.0
             -- # Filter max slider value : 10.0
             
             CIAttributeDescription = "The amount of adjustment to the shadows of the image.";
             -- # Filter display name : Shadow Amount
             -- # Filter default value : 0
             -- # Filter min slider value : -1.0
             -- # Filter max slider value : 1.0
             */
            tupel.min = -1.0 //
            tupel.max = 1.0
            tupel.startValue = 0.0
            tupel.valueName = "shadow amount"
            
        case .Highlights:
            
            /*
             ###################################### Filter name CIHighlightShadowAdjust
             
             -- # Filter display name : Highlight Amount
             -- # Filter default value : 1
             -- # Filter min slider value : 0.0
             -- # Filter max slider value : 1.0
             */
            
            tupel.min = 0.5 //
            tupel.max = 1.0
            tupel.startValue = 1.0
            tupel.valueName = "highlits amount"
            
        case .Sharpness:
            
            /*
             ###################################### Filter name CISharpenLuminance
             
             CIAttributeDescription = "The amount of sharpening to apply. Larger values are sharper.";
             -- # Filter display name : Sharpness
             -- # Filter default value : 0.4
             -- # Filter min slider value : 0.0
             -- # Filter max slider value : 2.0
             
             CIAttributeDescription = "The distance from the center of the effect.";
             -- # Filter display name : Radius
             -- # Filter default value : 1.69
             -- # Filter min slider value : 0.0
             -- # Filter max slider value : 20.0
             */
            tupel.min = -1.6
            tupel.max = 2.4
            tupel.startValue = 0.4
            tupel.valueName = "sharpness"
            tupel.zoomRecomended = true
            
        case .HueSkinTone:
            /*
             ###################################### Filter name CIHueAdjust
             CIAttributeDescription = "An angle (in radians) to use to correct the hue of an image.";
             Key = inputAngle
             
             -- # Filter display name : Angle
             -- # Filter default value : 0
             -- # Filter min slider value : 0.0
             -- # Filter max slider value : 0.0
             
             CIAttributeSliderMax = "3.141592653589793";
             CIAttributeSliderMin = "-3.141592653589793";
             */
            
            tupel.min = -0.15
            tupel.max = 0.15
            tupel.startValue = 0.0
            tupel.valueName = "inputAngle"
            
        case .Vibrance:
            
            /*
             CIAttributeDescription = "The amount to adjust the saturation.";
             Key. = "inputAmount"
           
             -- # Filter display name : Amount
             -- # Filter default value : 0
             -- # Filter min slider value : -1.0
             -- # Filter max slider value : 1.0
             */
            
            tupel.min = -1.0
            tupel.max = 1.0
            tupel.startValue = 0.0
            tupel.valueName = "inputAmount"
            
        case .Colored:
            
            tupel.min = 0.0
            tupel.max = 1.0
            tupel.startValue = 0.0
            tupel.valueName = "alpha"
            
        case .Brightness:
            tupel.min = -0.1
            tupel.max = 0.1
            tupel.startValue = 0.0
            tupel.valueName = "lightness"
            
        case .HSL_Hue:
            
            guard let hueParam = hue else {
                tupel.min = 0.0
                tupel.max = 1.0
                tupel.startValue = 0.5
                tupel.valueName = "hsl h"
                hslDataMode.lastShiftHueValue  = CGFloat(tupel.startValue)
                print("WARNINF: Missing parameter: hue value for HSL hues configuration")
                return tupel
            }
            tupel.min = hueParam.minSpecotor
            tupel.max = hueParam.maxSpecotor
            tupel.startValue = hueParam.midSpecotor
            tupel.valueName = "hsl h"
            hslDataMode.lastShiftHueValue  = CGFloat(tupel.startValue)
 
        case .HSL:
            
            tupel.min = 0.0
            tupel.max = 0.0
            tupel.startValue = 0.0
            tupel.composed = true
            tupel.valueName = "hsl"
            
        case .HSL_Saturation:
            
            tupel.min = 0.0
            tupel.max = 2.0
            tupel.startValue = 1.0
            tupel.valueName = "hsl s"
             
            hslDataMode.lastSaturationHueValue = CGFloat(tupel.startValue)
            
        case .HSL_Luminance:
            
            tupel.min = 0.5
            tupel.max = 1.5
            tupel.startValue = 1.0
            tupel.valueName = "hsl l"
            hslDataMode.lastLuminanceValue = CGFloat(tupel.startValue)
            
        case .FilterIntensity:
            
            tupel.min = 0.0
            tupel.max = 1.0
            tupel.startValue = 1.0
            tupel.valueName = "intensity"
            
          
        default:
            break
        }
        return tupel
    }
}
