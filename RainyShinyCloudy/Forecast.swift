//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by pranav gupta on 18/02/17.
//  Copyright © 2017 Pranav gupta. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    var _date: String!
    var _weatherType : String!
    var _highTemp: String!
    var _lowTemp: String!
    
    init(weatherDict: [String:Any]) {
        
        guard let temp = weatherDict["temp"] as? Dictionary<String,Any> else {
        print("could not bind weatherType in init")
        return
            }
        guard let max = temp["max"] as? Double else{print ("could not bind max temp in init")
        return
        }
        
        self._highTemp = String(max - 273.15)
        
        guard let min = temp["min"] as? Double else{print ("could not bind min temp in init")
            return
        }
        
        self._lowTemp = String(min - 273.15)
        
        guard let weather = weatherDict["weather"] as? [Dictionary<String,Any>] else {
            print ("could not bind weather in init")
            return
        }
        guard let main = weather[0]["main"] as? String else{
            print ("could not bind main in init")
            return
        }
        self._weatherType = main
        
        guard let date = weatherDict["dt"] as? Double else{
            print("could not bind date in init")
            return
        }
        // date that we receive from json is the unix converted date and we are extracting day out of it.
        
        let unixConvertedDate = Date(timeIntervalSince1970: date)
        self._date = unixConvertedDate.dayOfWeek()
        
        
    
        }
        
    var date : String {
        
    if _date == nil {
        _date = ""
    }
    return _date
        }
    
    var weatherType : String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp : String{
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    
    }

// extenstion to get the day of the week from the unix converted date.

extension Date{
    func dayOfWeek()-> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}


