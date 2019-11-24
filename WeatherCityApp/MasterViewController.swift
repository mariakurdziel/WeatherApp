//
//  MasterViewController.swift
//  WeatherCityApp
//
//  Created by maria on 11/7/19.
//  Copyright © 2019 maria. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
     @IBOutlet weak var citiesTable: UITableView!
    
    private let dataManager = DataManager(baseURL: API.AuthenticatedBaseURL)
    var longitude: String?
    var latitude: String?
    var weatherData: WeatherData?
    
    static var cities: [City] = [City(cityName: "Madrid", temperature: "52.3", latitude: "40.416775", longitude: "-3.703790"), City(cityName: "London", temperature: "41.2", latitude: "51.507351", longitude: "-0.127758"), City(cityName: "Warsaw", temperature:"48.2", latitude: "52.229675", longitude: "21.012230")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func searchCity(_ sender: Any) {
        performSegue(withIdentifier: "search", sender: sender)
    }
    
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MasterViewController.cities.count
    }
    
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
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        var icon: String?
        
        self.dataManager.getWeatherData(longitude: MasterViewController.cities[indexPath.row].longitude, latitude: MasterViewController.cities[indexPath.row].longitude) { (response, error) in
            if let JSON = response as? [String: AnyObject] {
                let weekData = JSON["daily"]
                icon = weekData?["icon"] as? String
            }
            
        }
        sleep(UInt32(1.5))
        
        cell.cityLabel?.text = MasterViewController.cities[indexPath.row].cityName
        cell.picture.image = setWeatherIcon(icon: icon!)
        cell.tempCell?.text = MasterViewController.cities[indexPath.row].temperature
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showdetail", sender: self)
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.city = MasterViewController.cities[(citiesTable.indexPathForSelectedRow?.row)!]
            citiesTable.deselectRow(at: citiesTable.indexPathForSelectedRow!, animated: true)

        }    }

    
}
