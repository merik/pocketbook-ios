//
//  Extensions.swift
//  PocketBook
//
//  Created by Chi on 12/1/18.
//  Copyright © 2018 dmc. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var jsonStringToDictionary: [String:Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                
            }
        }
        return nil
    }
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return dateFormatter.date(from: self)
    }
}
extension Date {
    var stringToDisplay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEEE dd MMM, yyyy"
        return dateFormatter.string(from: self).uppercased()
    }
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    var shortMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
}
extension Double {
    var asMoney: String {
        return "$" + String(format: self == floor(self) ? "%.0f": "%.2f", self)
        
    }
}
extension UIColor {
    
    
    
    convenience init(hex:Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    convenience init(hex: String) {
        var hexValue = hex
        if hex.hasPrefix("#") {
            hexValue = hex.substring(from: hex.index(hex.startIndex, offsetBy: 1))
        }
        var scanner = Scanner(string: hexValue)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        if !scanner.scanHexInt64(&rgbValue) {
            hexValue = "#478aff"
            scanner =  Scanner(string: hexValue)
            scanner.scanLocation = 0
            scanner.scanHexInt64(&rgbValue)
        }
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    
}
