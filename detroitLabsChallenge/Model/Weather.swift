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
    let dt : Int
    let main : Main
    let weather : [Weather]
}

struct Weather : Codable {
    
    let icon : String
}

struct FiveDaysWeather : Codable {
    
    let list : [SomeList]
}

struct SomeList : Codable {
    
    let dt : Int
    let main : Main
}

struct Main : Codable {
    let temp_min : Double
    let temp_max : Double
}
