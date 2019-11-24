//
//  DetailViewController.swift
//  WeatherCityApp
//
//  Created by maria on 11/8/19.
//  Copyright © 2019 maria. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var city: City?
    private let dataManager = DataManager(baseURL: API.AuthenticatedBaseURL)
    static var day: Int = 0;
    private let datesArray = ["29.10.2019","30.10.2019","31.10.2019","01.11.2019", "02.11.2019", "03.11.2019", "04.11.2019"]
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var summaryField: UILabel!
    @IBOutlet weak var minTempField: UILabel!
    @IBOutlet weak var maxTempField: UILabel!
    @IBOutlet weak var windBearField: UILabel!
    @IBOutlet weak var windSpeedField: UILabel!
    @IBOutlet weak var precipitationField: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var pressureField: UILabel!
    
    @IBAction func nextView(_ sender: UIButton) {
        if(DetailViewController.day < 6) {
            DetailViewController.day = DetailViewController.day + 1
            self.viewDidLoad()
        }
    }
    
    @IBAction func previousView(_ sender: Any) {
        if(DetailViewController.day > 0) {
            DetailViewController.day = DetailViewController.day - 1
            self.viewDidLoad()
        }    }
    
    private func setWeatherIcon(icon: String) -> UIImage {
        var imageName: String
        switch icon {
        case "partly-cloudy-day":
            imageName = "partlycloudy"
        case "cloudy":
            imageName = "cloud"
        case "rain":
            imageName =  "rain"
        default:
            imageName = "sun"
        }
        return UIImage(named: imageName)!
        
        
    }
    
    private func initProperties(weatherData: WeatherData){
        let weekDay = DetailViewController.day
        self.dateField.text = self.datesArray[weekDay]
        self.summaryField.text = weatherData.overallState
        self.minTempField.text = String(weatherData.minTemperature)
        self.maxTempField.text = String(weatherData.maxTemperature)
        self.windBearField.text = String(weatherData.windBearing)
        self.windSpeedField.text = String(weatherData.windSpeed)
        self.precipitationField.text = String(weatherData.precipitation)
        self.pressureField.text = String(weatherData.pressure)
        self.weatherIcon.image = setWeatherIcon(icon: weatherData.icon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName.text = city?.cityName
        let longitude = self.city?.longitude
        let latitude = self.city?.latitude
        let weekDay = DetailViewController.day
        var weatherData: WeatherData = WeatherData(overallState: "", icon: "", minTemperature: 0.0, maxTemperature: 0.0, windSpeed: 0.0, windBearing: 0.0, precipitation: 0.0, pressure: 0.0)
        
        self.dataManager.getWeatherData(longitude: longitude!, latitude: latitude!) { (response, error) in
            weatherData = JSONDecoder(Json:response as Any).decodeJSON(day: weekDay)
        }
        sleep(2)
        self.initProperties(weatherData: weatherData)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

