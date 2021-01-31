//
//  Extensions.swift
//  weatherDemo
//
//  Created by Andre Creighton on 1/29/21.
//

import Foundation
import UIKit

extension MainWeatherViewController {
  
  func handleLayout(){
    
    self.forecastTableViewHeightConstraint.constant = self.forecastTableView.contentSize.height + (self.cellSize * 4)
    self.forecastTableView.layoutIfNeeded()
    self.contentViewHeightConstraint.constant = self.forecastTableView.contentSize.height + self.cwView.frame.height - self.contentView.frame.height
    
  }
  
  func alertToSettings(){
      
    let alertVC = UIAlertController(title: "Location Disabled", message: "Turn on location settings", preferredStyle: .alert)
    
    let setAction = UIAlertAction(title: "Go to Settings", style: .default) { (action) in
      if let url = URL(string: UIApplication.openSettingsURLString){
        if UIApplication.shared.canOpenURL(url){
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
      }
    }
    
    alertVC.addAction(setAction)
    present(alertVC, animated: true, completion: nil)
    
  }
  
  func gradientView(){
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.view.bounds
    gradientLayer.colors = [UIColor.systemYellow.cgColor, UIColor.systemTeal.cgColor, UIColor.systemGreen.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    self.view.layer.insertSublayer(gradientLayer, at: 0)
    
  }
  
  
}


