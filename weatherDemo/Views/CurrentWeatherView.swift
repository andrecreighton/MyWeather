//
//  CurrentWeatherVIew.swift
//  weatherDemo
//
//  Created by Andre Creighton on 1/22/21.
//

import UIKit

protocol CurrentWeatherViewDelegate {
  
  func locationButtonTapped(_ sender:UIButton)
  
}

class CurrentWeatherView: UIView {
  
  let XIB_NAME = "CurrentWeatherView"
 
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var feelsLikeLabel: UILabel!
  @IBOutlet weak var currentTemperatureLabel: UILabel!
  @IBOutlet weak var tempDescriptionLabel: UILabel!
  @IBOutlet weak var lastUpdatedLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var windspeedsLabel: UILabel!
  @IBOutlet weak var precipitationLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  var delegate : CurrentWeatherViewDelegate!

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
    
  }
  
  private func commonInit(){
    Bundle.main.loadNibNamed(XIB_NAME, owner: self, options: nil)
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    contentView.frame = bounds
    addSubview(contentView)
    configureView()
  }
  
  private func configureView(){
    self.layer.cornerRadius = 10
    contentView.layer.cornerRadius = 10
    self.layer.shadowColor = UIColor.lightGray.cgColor
    self.layer.shadowOpacity = 0.4
    self.layer.shadowOffset = .zero
    self.layer.shadowRadius = 5
    
    locationLabel.layer.shadowColor = UIColor.lightGray.cgColor
    locationLabel.layer.shadowOpacity = 0.4
    locationLabel.layer.shadowOffset = .zero
    locationLabel.layer.shadowRadius = 5
    
    currentTemperatureLabel.layer.shadowColor = UIColor.lightGray.cgColor
    currentTemperatureLabel.layer.shadowOpacity = 0.4
    currentTemperatureLabel.layer.shadowOffset = .zero
    currentTemperatureLabel.layer.shadowRadius = 5
    
  }
  
  func updateView(_ currWeather: CurrentWeather){
    
    locationLabel.text = "\(currWeather.cityName), \(currWeather.stateCode)"
    humidityLabel.text = "Humidity: \(currWeather.rh)%"
    windspeedsLabel.text = "Winds at \(currWeather.windSpd)m/s going \(currWeather.windCdir)"
    precipitationLabel.text = "Precipitation: \(currWeather.precip) mm/hr"
    lastUpdatedLabel.text = "Updated as of: \(String(Int.epochToDayUsing(epochTime: currWeather.ts, desiredFormat: "MMM d, h:mm a")))"
    tempDescriptionLabel.text = currWeather.desc.weatherDescription
    currentTemperatureLabel.text = "\(String(Int(currWeather.temp.convertToFarenheit())))°"
    feelsLikeLabel.text = "Feels like \(String(Int(currWeather.appTemp.convertToFarenheit())))°"
    
  }
  
  @IBAction func locationButtonTapped(_ sender: UIButton) {
    
    delegate.locationButtonTapped(sender)
    
  }
  
  
}
