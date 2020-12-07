//
//  PhotoEditAction.swift
//  PhotoScanner
//
//  Created by Lilia Lashin on 27/09/2020.
//  Copyright © 2020 Lilia Lashin. All rights reserved.
//

import Foundation
import UIKit


public enum AdjustActionType: String {
 
    //Adjust photo
    case None = "None"
    case Exposure = "Exposure"
    case Contrast = "Contrast"
    case Saturation = "Saturation"
    case Vignette = "Vignette"
    case Temperature = "Temperature"
    case Tint = "Tint"
    case Grain = "Grain"
    case Shadow = "Shadow"
    case Highlights = "Highlights"
    case Sharpness = "Sharpness"
    case HueSkinTone = "HueSkin"
    case Vibrance = "Vibrance"
    case Fade = "Fade"
    case Colored = "Colored"
    case Brightness = "Brightness"
    case HSL = "HSL"
    case HSL_Hue = "HSL_Hue"
    case HSL_Saturation = "HSL_Saturation"
    case HSL_Luminance = "HSL_Luminance"
    case FilterIntensity = "FilterIntensity"
    
    
   public var description: String {
        
        switch self {
        case .None:
            return "None"
        case .Exposure:
            return "Exposure"
        case .Contrast:
            return "Contrast"
        case .Saturation:
            return "Saturation"
        case .Vignette:
            return "Vignette"
        case .Temperature:
            return "Temperature"
        case .Grain:
            return "Grain"
        case .Shadow:
            return "Shadow"
        case .Highlights:
            return "Highlights"
        case .Sharpness:
            return "Sharpness"
         case .HueSkinTone:
            return "Skin Tone"
        case .Vibrance:
            return "Vibrance"
        case .Fade:
            return "Fade"
        case .Colored:
            return "Colored Gel"
        case .Brightness:
            return "Brightness"
        case .HSL:
            return "HSL"
        case .HSL_Saturation:
            return "Saturation"
        case .HSL_Luminance:
            return "Lightness"
        case .Tint:
            return "Tint"
        case .HSL_Hue:
            return "Hue"
        case .FilterIntensity:
            return "Intensity"
        }
    }
    
    //    var iconImage: UIImage? {
    //        
    //        switch self {
    //        case .Filter:
    //            return R.image.filter()
    //        case .Retake:
    //            return R.image.retake()
    //        case .Crop:
    //            return R.image.crop()
    //        case .Text:
    //            return R.image.text()
    //        case .Collage:
    //            return R.image.collage()
    //        case .Adjust:
    //            return R.image.adjust()
    //        case .Size:
    //            return R.image.size()
    //        case .None:
    //            return UIImage(named: "edit")
    //        case .Exposure:
    //            return R.image.brightness()
    //        case .Contrast:
    //            return R.image.contrast()
    //        case .Saturation:
    //            return R.image.saturation()
    //        case .Vignette:
    //            return R.image.vignette()
    //        case .Temperature:
    //            return R.image.temperature()
    //        case .Grain:
    //            return R.image.grain()
    //        case .Shaddow:
    //            return R.image.shadow()
    //        case .Highlights:
    //            return R.image.highlights()
    //        case .Sharpness:
    //            return R.image.sharpness()
    //        case .Details:
    //            return R.image.details()
    //        case .Share:
    //            return R.image.shareAction()
    //        case .Save:
    //            return R.image.saveAction()
    //        case .Edit:
    //            return R.image.editAction()
    //        case .Move:
    //            return R.image.moveAction()
    //        case .Delete:
    //            return R.image.deleteAction()
    //        case .UpdateCover:
    //            return R.image.coverAction()
    //        case .DeleteAlbum:
    //            return R.image.trash()
    //        case .AlbumDetails:
    //            return R.image.edit1()
    //        case .DeleteText:
    //            return R.image.deleteAction()
    //        case .NewText:
    //            return R.image.addText()
    //        case .EditText:
    //            return R.image.editText()
    //        case .UploadiCloudDrive:
    //            return R.image.cloud()
    //        }
    //    }
}
 

