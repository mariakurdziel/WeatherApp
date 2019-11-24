//
//  API.swift
//  WeatherCityApp
//
//  Created by maria on 11/9/19.
//  Copyright © 2019 maria. All rights reserved.
//

import Foundation

struct API {
    
    static let APIKey = "15ee8d1a69f4c34dc685f0cf50a8608d"
    static let BaseURL = URL(string: "https://api.forecast.io/forecast/")!
    
    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(APIKey)
        
    }
}

