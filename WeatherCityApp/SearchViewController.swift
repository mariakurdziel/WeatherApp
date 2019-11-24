//
//  SearchViewController.swift
//  WeatherCityApp
//
//  Created by maria on 11/23/19.
//  Copyright © 2019 maria. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var found: Bool = false
    var name: String = ""
    var city: City? = nil
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsScopeBar = true
        searchBar.delegate = self
        setCityOnMap(found: found)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: Any) {
        MasterViewController.cities.append(city!)
        self.performSegue(withIdentifier: "back", sender: self)
    }
    func setCityOnMap(found: Bool) {
        if(found) {
            let cityCoord = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: cityCoord, span: span)
            myMapView.setRegion(region, animated: true)        }
    }
    
    func getCity(cityName: String) {
    
        let url = Bundle.main.url(forResource: "cities", withExtension: "json")!
        do {
            let data = try? Data(contentsOf: url)
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            guard let jsonArray = json as? [[String: Any]] else {
                return
            }
            //Now get title value
            var exist: Bool = false
            for obj in jsonArray {
                guard let city = obj["city"] as! String! else
                { return }
                if(city == cityName) {
                    exist = true
                    name = (obj["city"] as? String)!
                    latitude = (obj["lat"] as? Double)!
                    longitude = (obj["lng"] as? Double)!
                    break
                }
            }
            if(!exist) {
                textField.text = "Nie znaleziono"
            } else {
                textField.text = "Znaleziono"
                let temperature: Double = getTemperature()
                self.city = City(cityName: name, temperature: String(temperature), latitude: String(latitude), longitude: String(longitude))
                found = true
                self.viewDidLoad()
            }
            
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let city = searchBar.text as! String
        getCity(cityName: city)
    }
    
    func getTemperature() -> Double {
        return Double(arc4random_uniform(UInt32(40)))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
