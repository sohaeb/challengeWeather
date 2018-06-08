//
//  Weather.swift
//  detroitLabsChallenge
//
//  Created by may on 2018-06-08.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import Foundation

struct OpenWeather : Codable {
    
    let name : String
    let dt : String
    let main : Main
    let weather : [Weather]
}

struct Weather : Codable {

    let icon : String
}

struct Main : Codable {
    
    let temp : Double
    let humidity : Int
    let pressure : Int
    let temp_min : Double
    let temp_max : Double
}
