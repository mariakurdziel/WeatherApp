//
//  JSONDecoder.swift
//  WeatherCityApp
//
//  Created by maria on 11/9/19.
//  Copyright © 2019 maria. All rights reserved.
//

import Foundation

final class JSONDecoder {
    
    let JSON: Any
    
    init(Json: Any) {
        self.JSON = Json
    }
    
    func decodeJSON(day: Int) -> WeatherData{
        if let JSON = JSON as? [String: AnyObject] {
            if let dailyData = JSON["daily"]?["data"] as? [[String: AnyObject]] {
                
                if let overallState = dailyData[day]["summary"] as? String,
                    let icon = dailyData[day]["icon"] as? String,
                    let minTemperature = dailyData[day]["temperatureMin"] as? Double,
                    let maxTemperature = dailyData[day]["temperatureMax"] as? Double,
                    let windSpeed = dailyData[day]["windSpeed"] as? Double,
                    let windBearing = dailyData[day]["windBearing"] as? Double,
                    let precipitation = dailyData[day]["precipIntensity"] as? Double,
                    let pressure = dailyData[day]["pressure"] as? Double {
                    // Convert Time to Date
                    
                    return WeatherData(overallState: overallState, icon: icon, minTemperature: minTemperature, maxTemperature: maxTemperature, windSpeed: windSpeed, windBearing: windBearing, precipitation: precipitation, pressure: pressure)
                }
            }
        }
        return WeatherData(overallState: "", icon: "", minTemperature: 0.0, maxTemperature: 0.0, windSpeed: 0.0, windBearing: 0.0, precipitation: 0.0, pressure: 0.0)
        
    }
}
