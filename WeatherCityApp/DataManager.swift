//
//  DataManager.swift
//  WeatherCityApp
//
//  Created by maria on 11/9/19.
//  Copyright © 2019 maria. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    
    case Unknown
    case FailedRequest
    case InvalidResponse
    
}
final class DataManager {
    
    typealias WeatherDataCompletion = (AnyObject?, DataManagerError?) -> ()
    
    let baseURL: URL
    static var JSON: Any = {}
    
    init(baseURL: URL) {
        self.baseURL = API.AuthenticatedBaseURL
    }
    
    func getWeatherData(longitude: String, latitude: String, completion: @escaping WeatherDataCompletion) {
        let finalURL = baseURL.appendingPathComponent("\(latitude),\(longitude)")
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            self.didFetchWeatherData(data: data, response: response, error: error, completion: completion)
            }.resume()
    }
    
    private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: WeatherDataCompletion) {
        if let _ = error {
            completion(nil, .FailedRequest)
            
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                processWeatherData(data: data, completion: completion)
            } else {
                completion(nil, .FailedRequest)
            }
            
        } else {
            completion(nil, .Unknown)
        }
    }
    
    private func processWeatherData(data: Data, completion: WeatherDataCompletion) {
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
            DataManager.JSON = JSON
            completion(JSON, nil)
        } else {
            completion(nil, .InvalidResponse)
        }
    }
    
}
