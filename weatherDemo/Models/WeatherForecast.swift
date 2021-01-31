//
//  WeatherForecast.swift
//  weatherDemo
//
//  Created by Andre Creighton on 1/20/21.
//

import Foundation

struct ForecastData: Codable {
  
    let data: [WeatherForecast]
    let cityName, lon, timezone, lat: String
    let countryCode, stateCode: String

    enum CodingKeys: String, CodingKey {
        case data
        case cityName = "city_name"
        case lon, timezone, lat
        case countryCode = "country_code"
        case stateCode = "state_code"
    }
}
struct WeatherForecast : Codable {
  
      let moonriseTs: Int
      let windCdir: String
      let rh: Int
      let pres, highTemp: Double
      let sunsetTs: Int
      let ozone, moonPhase, windGustSpd, snowDepth: Double
      let clouds, ts, sunriseTs: Int
      let appMinTemp, windSpd: Double
      let pop: Int
      let windCdirFull: String
      let slp, moonPhaseLunation: Double
      let validDate: String
      let appMaxTemp, vis, dewpt, snow: Double
      let uv: Double
      let desc: Description
      let windDir: Int
      let maxDhi: Int?
      let cloudsHi: Int
      let precip, lowTemp, maxTemp: Double
      let moonsetTs: Int
      let datetime: String
      let temp, minTemp: Double
      let cloudsMid, cloudsLow: Int

      enum CodingKeys: String, CodingKey {
          case moonriseTs = "moonrise_ts"
          case windCdir = "wind_cdir"
          case rh, pres
          case highTemp = "high_temp"
          case sunsetTs = "sunset_ts"
          case ozone
          case moonPhase = "moon_phase"
          case windGustSpd = "wind_gust_spd"
          case snowDepth = "snow_depth"
          case clouds, ts
          case sunriseTs = "sunrise_ts"
          case appMinTemp = "app_min_temp"
          case windSpd = "wind_spd"
          case pop
          case windCdirFull = "wind_cdir_full"
          case slp
          case moonPhaseLunation = "moon_phase_lunation"
          case validDate = "valid_date"
          case appMaxTemp = "app_max_temp"
          case vis, dewpt, snow, uv
          case desc = "weather"
          case windDir = "wind_dir"
          case maxDhi = "max_dhi"
          case cloudsHi = "clouds_hi"
          case precip
          case lowTemp = "low_temp"
          case maxTemp = "max_temp"
          case moonsetTs = "moonset_ts"
          case datetime, temp
          case minTemp = "min_temp"
          case cloudsMid = "clouds_mid"
          case cloudsLow = "clouds_low"
      }
  
}

