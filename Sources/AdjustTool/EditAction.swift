//
//  File.swift
//  
//
//  Created by Lilia Lashin on 23/11/2020.
//

import Foundation

public class EditAction: Equatable {
    
   public var type: AdjustActionType = .None
   public var isSelected: Bool = false
    //var intensity: Float = 0
    
   public init( actionType: AdjustActionType) {
        type = actionType
    }
    
   public static func == (lhs: EditAction, rhs: EditAction) -> Bool {
        return lhs.type == rhs.type
    }
    
}
