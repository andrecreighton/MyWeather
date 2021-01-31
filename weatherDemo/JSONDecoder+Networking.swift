//
//  JSONDecoder+Networking.swift
//  weatherDemo
//
//  Created by Andre Creighton on 1/19/21.
//

import Foundation

extension URL {
  
  static func current(City city: String, State state: String, Country country: String ) -> URL {
    return makeForEndpoint("current?city=\(city)&state=\(state)&country=\(country)&key=\(URL.key)")
    
  }
  
  static func dailyForecast(City city: String, State state: String, Country country: String ) -> URL {
    return makeForEndpoint("forecast/daily?city=\(city)&state=\(state)&country=\(country)&key=\(URL.key)")
  }
  
}

private extension URL {
  
  static var key : String {
    "49e9e48997404213acaff658c11f8e3d"
  }
  
  static func makeForEndpoint(_ endpoint : String) -> URL {
    URL(string: "https://api.weatherbit.io/v2.0/\(endpoint)")!
  }
  
}

extension JSONDecoder {
  
  func decode<T: Decodable>(_ type: T.Type, fromUrl url: URL, completion: @escaping (T) -> Void){
    
    DispatchQueue.global().async {
      do{
        let data = try Data(contentsOf: url)
        let downloadedData = try self.decode(type, from: data)
      
        DispatchQueue.main.async {
          completion(downloadedData)
        }
      }catch{
        print("Error parsing data:" + error.localizedDescription)
      }
      
    }
    
  }
  
}
