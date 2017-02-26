//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by pranav gupta on 21/02/17.
//  Copyright © 2017 Pranav gupta. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init()  {}
    
    var latitude : Double!
    var longitude : Double!
    
}
