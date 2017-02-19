//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by pranav gupta on 16/02/17.
//  Copyright © 2017 Pranav gupta. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell{
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    func configureCell(forecast: Forecast){
        dayLabel.text = forecast.date
        weatherTypeLabel.text = forecast.weatherType
        highTempLabel.text = forecast.highTemp
        lowTempLabel.text = forecast.lowTemp
        thumb.image = UIImage(named: forecast.weatherType)
        
        
    }
    
}
