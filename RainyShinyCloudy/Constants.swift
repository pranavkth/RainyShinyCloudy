//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by pranav gupta on 16/02/17.
//  Copyright © 2017 Pranav gupta. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let API_KEY = "&appid=7d08b5f92e30f028f7a4deee05e06393"

let CURRENT_WEATHER_URL = BASE_URL + LATITUDE + String(Location.sharedInstance.latitude) + LONGITUDE + String(Location.sharedInstance.longitude)  + API_KEY

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=" + String(Location.sharedInstance.latitude) + "&lon=" + String(Location.sharedInstance.longitude) + "&cnt=16&appid=7d08b5f92e30f028f7a4deee05e06393"


typealias DownloadComplete  = () -> ()
