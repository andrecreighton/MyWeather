//
//  ViewController.swift
//  weatherDemo
//
//  Created by Andre Creighton on 1/16/21.
//

import UIKit
import CoreLocation


protocol LocationSearchDelegate {
  func locationInfo(_ city: String, _ state: String, _ country: String)
}



class MainWeatherViewController: UIViewController, LocationSearchDelegate {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var cwView: CurrentWeatherView!
  @IBOutlet weak var forecastTableView: UITableView!
  @IBOutlet weak var forecastTableViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
  
  var city = ""
  var state = ""
  var country = ""
  var arrayOfWeatherForecasts = [WeatherForecast]()
  
  var locationManager : CLLocationManager?
  var cellSize = CGFloat(60)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientView()
    
    forecastTableView.register(UINib(nibName: "WeatherForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "weatherCell")
    forecastTableView.delegate = self
    forecastTableView.dataSource = self
    cwView.delegate = self
    forecastTableView.isScrollEnabled = false
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    locationManagerHandler()
    
  }
  
  
  func locationInfo(_ city: String, _ state: String, _ country: String) {
    print(scrollView.isScrollEnabled)
    getWeatherData(city, state, country)
    getDailyForecast(city, state, country)
  }
  
  
}
extension MainWeatherViewController: CLLocationManagerDelegate {
  
  private func locationManagerSetup(){
    
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    locationManager?.requestWhenInUseAuthorization()
    
    let location = locationManager?.location?.coordinate
    getWeatherForLocation(location)
  }
  
  private func getWeatherForLocation(_ location: CLLocationCoordinate2D?){
    let geoCoder = CLGeocoder()
    
    guard let loc = location else {
      print("")
      return
    }
    
    let x = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
    
    geoCoder.reverseGeocodeLocation(x) { (placemark, err) in
      
      guard let place = placemark?.first else{
        return
      }
      
      self.getWeatherData(place.subLocality!, place.administrativeArea!, place.isoCountryCode!)
      self.getDailyForecast(place.subLocality!, place.administrativeArea!, place.isoCountryCode!)
    }
  }
  
  private func locationManagerHandler(){
    if CLLocationManager.locationServicesEnabled(){
      locationManagerSetup()
    }else{
      alertToSettings()
    }
  }
  
  
  
}

extension MainWeatherViewController : CurrentWeatherViewDelegate {
  
  func locationButtonTapped(_ sender: UIButton) {
    //
    handleLayout()
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "location") as! LocationSearchViewController
    vc.delegate = self
    self.present(vc, animated: true, completion: nil)
    
  }
  
}


extension MainWeatherViewController : UITableViewDelegate, UITableViewDataSource {
  
  private func getWeatherData(_ city: String, _ state: String, _ country: String){
    let url = URL.current(City: city, State: state, Country: country)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.decode(WeatherData.self, fromUrl: url) { weatherData in
      guard let wO = weatherData.data.first else{
        return
      }
      self.cwView.updateView(wO)
    }
  }
  
  private func getDailyForecast(_ city: String, _ state: String, _ country: String){
    let url = URL.dailyForecast(City: city, State: state, Country: country)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.decode(ForecastData.self, fromUrl: url) { forecast in
      self.arrayOfWeatherForecasts = forecast.data
      self.forecastTableView.reloadData()
      self.handleLayout()
    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayOfWeatherForecasts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = forecastTableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherForecastTableViewCell
    
    cell.configureCell(arrayOfWeatherForecasts[indexPath.row])
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return cellSize
    
  }
  
}
