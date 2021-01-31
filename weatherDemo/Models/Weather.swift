//
//  Weather.swift
//  weatherDemo
//
//  Created by Andre Creighton on 1/16/21.
//

import Foundation


struct WeatherData : Codable {
  
  var data: [CurrentWeather]
  var count: Int

}

struct CurrentWeather : Codable {
  
  let rh: Int
     let pod: String
     let lon, pres: Double
     let timezone, obTime, countryCode: String
     let clouds, ts: Int
     let solarRAD: Double
     let stateCode, cityName: String
     let windSpd: Double
     let windCdirFull, windCdir: String
     let slp: Double
     let vis, hAngle: Int
     let sunset: String
     let dni, dewpt: Double
     let snow: Int
     let uv: Double
     let precip, windDir: Int
     let sunrise: String
     let ghi, dhi: Double
     let aqi: Int
     let lat: Double
     let desc: Description
     let datetime: String
     let temp: Double
     let station: String
     let elevAngle, appTemp: Double

     enum CodingKeys: String, CodingKey {
         case rh, pod, lon, pres, timezone
         case desc = "weather"
         case obTime = "ob_time"
         case countryCode = "country_code"
         case clouds, ts
         case solarRAD = "solar_rad"
         case stateCode = "state_code"
         case cityName = "city_name"
         case windSpd = "wind_spd"
         case windCdirFull = "wind_cdir_full"
         case windCdir = "wind_cdir"
         case slp, vis
         case hAngle = "h_angle"
         case sunset, dni, dewpt, snow, uv, precip
         case windDir = "wind_dir"
         case sunrise, ghi, dhi, aqi, lat, datetime, temp, station
         case elevAngle = "elev_angle"
         case appTemp = "app_temp"
     }
}

struct Description: Codable {
  let icon: String
      let code: Int
      let weatherDescription: String

      enum CodingKeys: String, CodingKey {
          case icon, code
          case weatherDescription = "description"
      }
}
