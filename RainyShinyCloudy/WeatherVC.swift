//
//  WeatherVC.swift
//  RainyShinyCloudy
//
//  Created by Pranav Gupta on 15/02/17.
//  Copyright © 2017 Pranav gupta. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation


class WeatherVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    
    
    var currentWeather = CurrentWeather()
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // when in use authorisation works only when the app is running and active on the screen.
        // alwaysauthorised is required in apps such as google maps which can pull the location data even when the app is not in use.
        
        locationManager.requestWhenInUseAuthorization()
        
        // this will start monitoring significant location changes.
        
        locationManager.startMonitoringSignificantLocationChanges()
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.locationAuthStatus()
    }
    // function to check authorisation.
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude, "are the coordinates")
            currentWeather.downloadWeatherDetails(){
                self.downloadForecastData {
                    self.updateMainUI()
                    self.tableView.reloadData()
                }
            }

        }
        else
        {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    // function to download forecast data.
    func downloadForecastData(completed: @escaping DownloadComplete){
        
        let forecastUrl = URL(string: FORECAST_URL)!
        Alamofire.request(forecastUrl).responseJSON {
            response in
            let result = response.result
            switch result {
                
            case .success:
                print("success")
                guard let dict = result.value as? Dictionary<String,Any>   else {
                print("could not cast dict")
                return }
                guard let list = dict["list"] as? [Dictionary<String,Any>] else {
                    print("could not cast list")
                    return
                }
                for obj in list {
                    let forecast =  Forecast(weatherDict: obj)
                    self.forecasts.append(forecast)
                }
                    
            case.failure(let error):
                print(error.localizedDescription)
            }
            completed()
            
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns one row less than the 16 rows returned by api- excludes the one containing today's data.
        
        
        return forecasts.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // to change.
        if let cell = tableView.dequeueReusableCell(withIdentifier:"WeatherCell" , for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row + 1]
            cell.configureCell(forecast: forecast)
            return cell
        }
        else{
            return WeatherCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func updateMainUI(){
        print("mainuicalled")
        print("location is \(currentWeather.cityName)")
        print("temp is \(currentWeather.currentTemp)")
        print("weather type is \(currentWeather.weatherType)")
        
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(currentWeather.currentTemp)
        locationLabel.text = currentWeather.cityName
        currentWeatherLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        }
    
    
}

