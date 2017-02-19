//
//  WeatherVC.swift
//  RainyShinyCloudy
//
//  Created by pranav gupta on 15/02/17.
//  Copyright © 2017 Pranav gupta. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.downloadForecastData {
            self.tableView.reloadData()
        }
        currentWeather.downloadWeatherDetails(){
            self.updateMainUI()
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

