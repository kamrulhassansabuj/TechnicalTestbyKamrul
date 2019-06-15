//
//  InsertView.swift
//  TechnicalTest
//
//  Created by Interview AITS on 15/6/19.
//  Copyright © 2019 Interview AITS. All rights reserved.
//

import UIKit

class InsertViewLayout: UIView {
    
    @IBInspectable  var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable  var cornerRadius: CGFloat {
        set {
            
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable  var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    
    
}
