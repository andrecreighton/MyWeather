//
//  Utilities.swift
//  weatherDemo
//
//  Created by Andre Creighton on 1/19/21.
//

import Foundation
import UIKit


extension Double {
  
   func convertToFarenheit() -> Double{
    
    return (self * 9) / 5 + 32
    
  }
  
   func convertToCelsius() -> Double{
   
   return (self - 32) * 5 / 9
   
 }
}

extension UIColor {
  
  static func dayColor() -> UIColor {
    return UIColor(red: 157.0/255.0, green: 198.0/255.0, blue: 255.0/255.0, alpha: 1)
  }
  
  static func nightColor() -> UIColor {
    return UIColor(red: 34.0/255.0, green: 76.0/255.0, blue: 115.0/255.0, alpha: 1)
  }
  
}



extension Int {
  
  static func epochToDayUsing(epochTime epoch: Int, desiredFormat format: String) -> String {
    
    let date = Date(timeIntervalSince1970: Double(epoch))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = .current
    dateFormatter.dateFormat = format
    let localDate = dateFormatter.string(from: date) 
    
    return localDate.description
    
  }
  
}
