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

extension AdjustToolsKit {
   
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

extension AdjustToolsKit {
    
    
    func configureSliderValues(for editAction: AdjustActionType?, hue: HueColor?) -> SliderConfiguration {
        
        var tupel = SliderConfiguration(min: Float(0), max: Float(0), startValue: Float(0), valueName: "")
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
            
            tupel.min = hue!.minSpecotor
            tupel.max = hue!.maxSpecotor
            tupel.startValue = hue!.midSpecotor
            tupel.valueName = "hsl h"
            hslDataMode.lastShiftHueValue  = CGFloat(tupel.startValue)
 
        case .HSL:
            
            tupel.min = 0.0
            tupel.max = 1.0
            tupel.startValue = 0.5
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
          
        default:
            break
        }
        return tupel
    }
}
// removed extensions
extension AdjustToolsKit {
    
    func exposureFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
      
        guard let filter = CIFilter(name: "CIExposureAdjust") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputEVKey)
        return (filter.outputImage)!
    }
    
     func contrastFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
       
        guard let filter = CIFilter(name: "CIColorControls") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputContrastKey)
        return (filter.outputImage)!
    }
    
     func brightnessFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIColorControls") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputBrightnessKey)
        return (filter.outputImage)!
    }
    
     func fadeFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
       
        guard let filter = CIFilter(name: "CIColorControls") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: 2 - intensity), forKey: kCIInputContrastKey)
        return (filter.outputImage)!
    }
 
     func saturationFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
      
        guard let filter = CIFilter(name: "CIColorControls") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputSaturationKey)
        return (filter.outputImage)!
    }
    
     func sharpnessFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
       
        guard let filter = CIFilter(name: "CISharpenLuminance") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputSharpnessKey)
        return (filter.outputImage)!
    }
    
     func vignetteFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
       
        guard let filter = CIFilter(name: "CIVignette") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputIntensityKey)
        return (filter.outputImage)!
    }
    
     func highlightFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
       
        guard let filter = CIFilter(name: "CIHighlightShadowAdjust") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: "inputHighlightAmount")
        return (filter.outputImage)!
    }
    
     func temperatureFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        // light in Lelvins
        //print("Temperature intensity \(intensity)")
        guard let filter = CIFilter(name: "CITemperatureAndTint") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        let temperatureVector = CIVector(x: CGFloat(intensity), y: CGFloat(0))
        filter.setValue(temperatureVector, forKey: "inputNeutral")
        return (filter.outputImage)!
    }
    
     func tintFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CITemperatureAndTint") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        let vector1 = CIVector(x: 6500, y: CGFloat(intensity))
        filter.setValue(vector1, forKey: "inputNeutral")
        return (filter.outputImage)!
    }
    
     func shadowFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
       
        guard let filter = CIFilter(name: "CIHighlightShadowAdjust") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: "inputShadowAmount")
        return (filter.outputImage)!
    }
 
     func grainFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
 
        let coloredNoise = CIFilter(name:"CIRandomGenerator")
        let noiseImage = coloredNoise?.outputImage
        
        
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(noiseImage, forKey: "inputImage")
        filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")
        filter?.setValue(1.0, forKey: "inputIntensity")
        guard let outputImage = filter?.outputImage else { return img}
        
 
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        UIColor.white.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        guard let colorMatrix = CIFilter(name: "CIColorMatrix") else {return img}
        colorMatrix.setDefaults()
        colorMatrix.setValue(outputImage, forKey: "inputImage")
        colorMatrix.setValue(CIVector(x: r, y: 0, z: 0, w: 0), forKey: "inputRVector")
        colorMatrix.setValue(CIVector(x: 0, y: g, z: 0, w: 0), forKey: "inputGVector")
        colorMatrix.setValue(CIVector(x: 0, y: 0, z: b, w: 0), forKey: "inputBVector")
        colorMatrix.setValue(CIVector(x: 0, y: 0, z: 0, w: CGFloat(intensity)), forKey: "inputAVector")
 
        let darkScratches = colorMatrix.outputImage//grayscaleFilter?.outputImage
        
        let oldFilmCompositor = CIFilter(name:"CIMultiplyCompositing",
                                         parameters:
                                            [
                                                kCIInputImageKey: darkScratches as Any,
                                                kCIInputBackgroundImageKey: img
                                            ])
        let oldFilmImage = oldFilmCompositor?.outputImage
        // return oldFilmImage!
        
        let last = CIFilter(name:"CISourceOverCompositing",
                            parameters:
                                [
                                    kCIInputImageKey: oldFilmImage as Any,
                                    kCIInputBackgroundImageKey: img
                                ])
        
        return (last?.outputImage)!
        
    }
 
     func coloredFilter(img: CIImage, withAmount intensity: Float, color: UIColor) -> CIImage {
        
        
        guard  let colorMatrix = CIFilter(name: "CIColorMatrix")
        else { return img }
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightniss: CGFloat = 0, alpha: CGFloat = 0
        color.getHue(&hue, saturation: &saturation, brightness: &brightniss, alpha: &alpha)
        
        colorMatrix.setDefaults()
        colorMatrix.setValue(img, forKey: "inputImage")
        colorMatrix.setValue(CIVector(x: r, y: 0, z: 0, w: 0), forKey: "inputRVector")
        colorMatrix.setValue(CIVector(x: 0, y: g, z: 0, w: 0), forKey: "inputGVector")
        colorMatrix.setValue(CIVector(x: 0, y: 0, z: b, w: 0), forKey: "inputBVector")
        colorMatrix.setValue(CIVector(x: 0, y: 0, z: 0, w: CGFloat(intensity)), forKey: "inputAVector")
        
        let speckCompositor = CIFilter(name:"CISourceOverCompositing",
                                       parameters:
                                        [
                                            kCIInputImageKey: colorMatrix.outputImage as Any,
                                            kCIInputBackgroundImageKey: img
                                        ])
        let speckledImage = speckCompositor?.outputImage
        return speckledImage!//colorMatrix.outputImage!
    }
    
     func skinToneFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIHueAdjust") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: "inputAngle")
        return (filter.outputImage)!
    }
    
     func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    
     func HSLHueFilter(img: CIImage, withAmount intensity: Float, hueColour: HueColor? = .red) -> CIImage {
        
        let filter = MultiBandHSV()
        filter.inputImage = img
        
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        let basicColour  = hueColour!.colour
        basicColour.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        hue =  CGFloat(hueColour!.midSpecotor)
        
        // print("---- intensity from slider \(intensity)")
        hue = fmod(CGFloat(intensity) - CGFloat(hue),1.0)//fmod(hue + CGFloat(delta),1.0)
       // bgrV?.backgroundColor = UIColor(hue: CGFloat(intensity), saturation: saturation, brightness: brightness, alpha: 1)
        hslDataMode.lastShiftHueValue = hue
        
        switch hueColour {
        case .red:
            filter.inputRedShift = CIVector(x: hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: hslDataMode.lastLuminanceValue!)
        case .none:
            break
        case .orange:
            filter.inputOrangeShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: hslDataMode.lastLuminanceValue!)
        case .yellow:
            filter.inputYellowShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: hslDataMode.lastLuminanceValue!)
        case .green:
            filter.inputGreenShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: hslDataMode.lastLuminanceValue!)
        case .blue:
            filter.inputBlueShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: hslDataMode.lastLuminanceValue!)
        case .magenta:
             filter.inputMagentaShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: hslDataMode.lastLuminanceValue!)
        }
        
        return filter.outputImage!
     }
    
     func HSLSaturationFilter(img: CIImage, withAmount intensity: Float, hueColour: HueColor? = .red) -> CIImage {
        
        let filter = MultiBandHSV()
        filter.inputImage = img
        
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        let basicColour  = hueColour!.colour
        basicColour.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        hue =  CGFloat(hueColour!.midSpecotor)
        
        saturation = saturation + CGFloat(intensity)
 
        hslDataMode.lastSaturationHueValue = CGFloat(intensity)
        switch hueColour {
        case .red:
            filter.inputRedShift = CIVector(x: hslDataMode.lastShiftHueValue!, y: CGFloat(intensity), z: hslDataMode.lastLuminanceValue!)
        case .none:
            break
        case .orange:
            filter.inputOrangeShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: CGFloat(intensity), z: hslDataMode.lastLuminanceValue!)
        case .yellow:
            filter.inputYellowShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: CGFloat(intensity), z: hslDataMode.lastLuminanceValue!)
        case .green:
            filter.inputGreenShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: CGFloat(intensity), z: hslDataMode.lastLuminanceValue!)
        case .blue:
            filter.inputBlueShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: CGFloat(intensity), z: hslDataMode.lastLuminanceValue!)
        case .magenta:
            filter.inputMagentaShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: CGFloat(intensity), z: hslDataMode.lastLuminanceValue!)
        }
        
        return filter.outputImage!
    }
    
     func HSLLuminenceFilter(img: CIImage, withAmount intensity: Float, hueColour: HueColor? = .red) -> CIImage {
        
        let filter = MultiBandHSV()
        filter.inputImage = img
        
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        let basicColour  = hueColour!.colour
        basicColour.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        hue =  CGFloat(hueColour!.midSpecotor)
        brightness = brightness + CGFloat(intensity)
        
        hslDataMode.lastLuminanceValue = CGFloat(intensity)
        switch hueColour {
        case .red:
            filter.inputRedShift = CIVector(x: hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: CGFloat(intensity))
        case .none:
            break
        case .orange:
            filter.inputOrangeShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: CGFloat(intensity))
        case .yellow:
            filter.inputYellowShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: CGFloat(intensity))
        case .green:
            filter.inputGreenShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: CGFloat(intensity))
        case .blue:
            filter.inputBlueShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: CGFloat(intensity))
        case .magenta:
            filter.inputMagentaShift = CIVector(x:  hslDataMode.lastShiftHueValue!, y: hslDataMode.lastSaturationHueValue!, z: CGFloat(intensity))
        }
        return filter.outputImage!
     }
 
     func vibranceFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
      
        guard let filter = CIFilter(name: "CIVibrance") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: "inputAmount")
        return (filter.outputImage)!
    }
}


