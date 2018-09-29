//
//  Network.swift
//  detroitLabsChallenge
//
//  Created by may on 2018-06-27.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import Foundation

class Network {
    
    var todo : OpenWeather?
    
    static let shared = Network()
    
    init(){
        todo = nil
    }
    
    func download() -> OpenWeather {
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(0)&lon=\(0)&APPID=\(Constants.API_KEY)")
        
        // Create a new dataTask that returns downloaded data
        URLSession.shared.dataTask(with: url!) {( data, response, error ) in
            
            guard let content = data else {
                print("No data was downloaded using URL session")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                
                self.todo = try decoder.decode(OpenWeather.self, from: content)
                
            } catch {
                print("error trying to convert data to JSON in URLsession taks func")
            }
            
        }
        
        return todo!

    }
    
}



//
//                //              assign them to new vars
//                self.nameOfCity = todo.name
//
//                //1st convert it to F
//                let faher = todo.main.temp.convertToF()
//                // truncate it to get 2 digits only
//                self.currentTemp = String(format: "%.0f", faher)
//
//                self.iconCode = todo.weather[0].icon


//            DispatchQueue.main.async {
//
//                self.currentTempLabel.text = self.currentTemp
//                self.currentCityOutlet.text = self.nameOfCity
//
//                // create a URL to download icons
//                guard let url = URL(string: "http://openweathermap.org/img/w/\(self.iconCode).png") else {
//                    print("url not working")
//                    return
//                }
//
//                // Download the icon from the URL
//                let downloadedImage = try? UIImage(data: Data(contentsOf: url))
//
//                if let downloadedImage = downloadedImage {
//                    self.CurrentWeatherimageView.image = downloadedImage
//                }
//
//            }
