//
//  WeatherForecastTableViewCell.swift
//  weatherDemo
//
//  Created by Andre Creighton on 1/28/21.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {

  @IBOutlet weak var dayOfLabel: UILabel!
  @IBOutlet weak var highAndLowLabel: UILabel!
  @IBOutlet weak var weatherImageView: UIImageView!
  
  func configureCell(_ forecastData: WeatherForecast){
    
    let highTemp = String(Int(forecastData.highTemp.convertToFarenheit())) + " | "
    let lowTemp = String(Int(forecastData.lowTemp.convertToFarenheit()))

    highAndLowLabel.attributedText = formatTempString(highTemp, lowTemp)
    let image = UIImage(named: forecastData.desc.icon)
    let dayOfWeek = Int.epochToDayUsing(epochTime: forecastData.ts, desiredFormat: "EE, M/d")
    weatherImageView.image = image
    dayOfLabel.text = dayOfWeek
    
  }
  
  private func formatTempString(_ stringA : String, _ stringB: String) -> NSMutableAttributedString {
    
    let attributes: [NSAttributedString.Key: Any] = [
      .font: UIFont(name: "Avenir Next Medium", size: 18)!,
      .foregroundColor: UIColor.darkGray,
    ]
    let attributesB: [NSAttributedString.Key: Any] = [
      .font: UIFont(name: "Avenir Next Medium", size: 18)!,
      .foregroundColor: UIColor.white,
    ]
    let highTempString = NSAttributedString(string: stringA, attributes: attributesB)
    let lowTempString = NSAttributedString(string: stringB, attributes: attributes)
    let newString = NSMutableAttributedString(attributedString: highTempString)
    newString.append(lowTempString)

    return newString
  }
  
    
}
