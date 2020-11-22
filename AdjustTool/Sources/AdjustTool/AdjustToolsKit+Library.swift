//
//  AdjustToolsKit+Library.swift
//  AdjustTool
//
//  Created by Lilia Lashin on 19/11/2020.
//

import Foundation
import UIKit

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
