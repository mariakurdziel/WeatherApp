//
//  City.swift
//  WeatherCityApp
//
//  Created by maria on 11/7/19.
//  Copyright © 2019 maria. All rights reserved.
//

import Foundation

struct City {
    
    public let cityName: String
    public let temperature: String
    public let latitude: String
    public let longitude: String
    
    
    public init(cityName: String, temperature: String, latitude: String, longitude: String) {
        self.cityName = cityName
        self.temperature = temperature
        self.latitude = latitude
        self.longitude = longitude
    }
}
