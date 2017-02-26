//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by pranav gupta on 16/02/17.
//  Copyright © 2017 Pranav gupta. All rights reserved.
//

import UIKit
import Alamofire


class CurrentWeather{
    var _cityName : String!
    var _date: String!
    var _weatherType : String!
    var _currentTemp: Double!
    var error : String = ""
    var flag = 1

    var cityName: String{
        if _cityName == nil{
            _cityName = "nil"
        }
        return _cityName
    }
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        // DateFormatter is a class for using dates in our app. here we are creating an object of that class.Date() provides the current date and dateformatter saves the style of the date.
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today," + currentDate
        return _date
    }
    
    var weatherType : String{
        if _weatherType == nil{
            _weatherType = "nil"
        }
        return _weatherType
    }
    
    var currentTemp : Double{
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        // IN INFO.PLIST file use App Transport Security Settings and update key allow arbitrary loads to YES.
        
        print("downloadweather ", Location.sharedInstance.latitude,Location.sharedInstance.longitude
        )
        
        let currentWeatherUrl = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherUrl).responseJSON { response in
            // HERE IT RETURNS RESPONSE WHOSE RESULT IS SUCCESS AND VALUE IS A OBJECT.
                let result = response.result
            switch result {
            case .success:
                print("success in working ")
                
                // JSON PARSING STARTS HERE.
                guard let dict = result.value as? Dictionary<String,Any> else {print("error")
                    return }
                guard let name = dict["name"] as? String else {print("error 2 ")
                    return }
                self._cityName = name.capitalized
                
                guard let weather = dict["weather"] as? [Dictionary<String,Any>] else {print("error 3 ")
                    return }
                guard let weatherType = weather[0]["main"] as? String else { return }
                self._weatherType = weatherType.capitalized
                guard let main = dict["main"] as? Dictionary<String,Any> else { return }
                guard var currentTemp = main["temp"] as? Double else{ return }
                currentTemp = round(currentTemp-273.15)
                self._currentTemp = currentTemp
                self._date = self.date
                                        print(self._date)
                                        print(self._cityName)
                                        print(self._weatherType)
                                        print(self._currentTemp)
            
            case .failure(let error):
                self.flag = 0
                print(self.flag)
                print(error.localizedDescription)
                self.error = error.localizedDescription
            }
            
                completed()
            }
            
            }
        }
        




