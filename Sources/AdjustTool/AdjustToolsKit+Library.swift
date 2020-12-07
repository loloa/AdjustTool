//
//  AdjustToolsKit+Library.swift
//  AdjustTool
//
//  Created by Lilia Lashin on 19/11/2020.
//

import Foundation
import UIKit

@available(iOS 10.0, *)
extension AdjustToolsKit {
    
    public func exposureFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIExposureAdjust") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputEVKey)
        return (filter.outputImage)!
    }
    
    public func contrastFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIColorControls") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputContrastKey)
        return (filter.outputImage)!
    }
    
    public func brightnessFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIColorControls") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputBrightnessKey)
        return (filter.outputImage)!
    }
    
    public func fadeFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIColorControls") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: 2 - intensity), forKey: kCIInputContrastKey)
        return (filter.outputImage)!
    }
    
    public func saturationFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIColorControls") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputSaturationKey)
        return (filter.outputImage)!
    }
    
    public func sharpnessFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CISharpenLuminance") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputSharpnessKey)
        return (filter.outputImage)!
    }
    
    public func vignetteFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIVignette") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: kCIInputIntensityKey)
        return (filter.outputImage)!
    }
    
    public func highlightFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIHighlightShadowAdjust") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: "inputHighlightAmount")
        return (filter.outputImage)!
    }
    
    public func temperatureFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        // light in Lelvins
        //print("Temperature intensity \(intensity)")
        guard let filter = CIFilter(name: "CITemperatureAndTint") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        let temperatureVector = CIVector(x: CGFloat(intensity), y: CGFloat(0))
        filter.setValue(temperatureVector, forKey: "inputNeutral")
        return (filter.outputImage)!
    }
    
    public func tintFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CITemperatureAndTint") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        let vector1 = CIVector(x: 6500, y: CGFloat(intensity))
        filter.setValue(vector1, forKey: "inputNeutral")
        return (filter.outputImage)!
    }
    
    public func shadowFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        
        guard let filter = CIFilter(name: "CIHighlightShadowAdjust") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: "inputShadowAmount")
        return (filter.outputImage)!
    }
    
    public func grainFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
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
    
    public func coloredFilter(img: CIImage, withAmount intensity: Float, color: UIColor) -> CIImage {
        
        
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
    
    public func skinToneFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIHueAdjust") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: "inputAngle")
        return (filter.outputImage)!
    }
    
    public func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    
    public func HSLHueFilter(img: CIImage, withAmount intensity: Float, hueColour: HueColor? = .red) -> CIImage {
        
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
    
    public func HSLSaturationFilter(img: CIImage, withAmount intensity: Float, hueColour: HueColor? = .red) -> CIImage {
        
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
    
    public func HSLLuminenceFilter(img: CIImage, withAmount intensity: Float, hueColour: HueColor? = .red) -> CIImage {
        
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
    
    public func vibranceFilter(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        guard let filter = CIFilter(name: "CIVibrance") else {return img}
        filter.setValue(img, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: intensity), forKey: "inputAmount")
        return (filter.outputImage)!
    }
    
    
    public func manageFilterIntensity(_ originalImage: UIImage?,
                                      filteredImage: UIImage?,
                                      intensity: CGFloat ) -> UIImage? {
        
        guard let original = originalImage, let filtered = filteredImage else {
            return originalImage
        }
        
       // original = AdjustToolsKit.resizeImageIfNeeded(original, withSize: filtered.size.width)
        
        guard let ciOriginal = CIImage(image: original) else { return original }
        guard let ciFiltered = CIImage(image: filtered) else { return original }
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        UIColor.white.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        guard let colorMatrix = CIFilter(name: "CIColorMatrix") else {return original}
        colorMatrix.setDefaults()
        colorMatrix.setValue(ciFiltered, forKey: "inputImage")
        colorMatrix.setValue(CIVector(x: r, y: 0, z: 0, w: 0), forKey: "inputRVector")
        colorMatrix.setValue(CIVector(x: 0, y: g, z: 0, w: 0), forKey: "inputGVector")
        colorMatrix.setValue(CIVector(x: 0, y: 0, z: b, w: 0), forKey: "inputBVector")
        colorMatrix.setValue(CIVector(x: 0, y: 0, z: 0, w: CGFloat(intensity)), forKey: "inputAVector")
        
        let last = CIFilter(name: "CISourceOverCompositing",
                            parameters:
                                [
                                    kCIInputImageKey: colorMatrix.outputImage as Any,
                                    kCIInputBackgroundImageKey: ciOriginal
                                ])
        
        
        
        guard let outputImage = last?.outputImage,
              let cgImage = context.createCGImage(outputImage, from: ciOriginal.extent) else {
             return original
        }
        
        let newImage = UIImage(cgImage: cgImage, scale:1, orientation: original.imageOrientation)
        return newImage
 
    }
}
