//
//  WeatherData.swift
//  WeatherCityApp
//
//  Created by maria on 11/9/19.
//  Copyright © 2019 maria. All rights reserved.
//

import Foundation

struct WeatherData {
    
    public let overallState: String
    public let icon: String
    public let minTemperature: Double
    public let maxTemperature: Double
    public let windSpeed: Double
    public let windBearing: Double
    public let precipitation: Double
    public let pressure: Double
    
    public init(overallState: String, icon: String, minTemperature: Double, maxTemperature: Double, windSpeed: Double, windBearing: Double, precipitation: Double, pressure: Double) {
        self.overallState = overallState
        self.icon = icon
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.windSpeed = windSpeed
        self.windBearing = windBearing
        self.precipitation = precipitation
        self.pressure = pressure
    }
}
