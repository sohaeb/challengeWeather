//
//  FirstViewController.swift
//  detroitLabsChallenge
//
//  Created by may on 2018-06-08.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentViewController: UIViewController {
      // MARK:- Outlets
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var CurrentWeatherimageView: UIImageView!
    @IBOutlet weak var currentCityOutlet: UILabel!
    
    // MARK:- Constants & Vars
    
    let locationManagerVar = CLLocationManager()
    
    var nameOfCity = ""
    var currentTemp = ""
    var iconCode = ""
    
    // MARK:- Functions
    
    //
    // This method will download JSON data from api.openweathermap.org
    //
    func download(lat: Double, long: Double) {
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&APPID=\(Constants.API_KEY)")
        
        // Create a new dataTask that returns downloaded data
        URLSession.shared.dataTask(with: url!) {( data, response, error ) in
            
//            print("response is \(response)")
            
            if error == nil {
                
            } else {
                print("The error inside URL Session is: \(String(describing: error?.localizedDescription))")
                
                DispatchQueue.main.async {
                    //("main async called now inside URL session")
                   
                }
                return
            }
            
            guard let content = data else {
                print("No data was downloaded using URL session")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                
                let todo = try decoder.decode(OpenWeather.self, from: content)
                
//              assign them to new vars
                self.nameOfCity = todo.name
                
                //1st convert it to F
                let faher = todo.main.temp.convertToF()
                // truncate it to get 2 digits only
                self.currentTemp = String(format: "%.0f", faher)
                
                self.iconCode = todo.weather[0].icon
                
            } catch {
                print("error trying to convert data to JSON in URLsession taks func")
            }
            
            DispatchQueue.main.async {
                
                self.currentTempLabel.text = self.currentTemp
                self.currentCityOutlet.text = self.nameOfCity
                
                guard let url = URL(string: "http://openweathermap.org/img/w/\(self.iconCode).png") else {
                    print("url not working")
                    return
                }
                
                let downloadedImage = try? UIImage(data: Data(contentsOf: url))
                
                if let downloadedImage = downloadedImage {
                    self.CurrentWeatherimageView.image = downloadedImage
                }
                
            }
            
            }.resume()
        
        //("reached end of URL session func")
    }
    
    
    // MARK: ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManagerVar.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManagerVar.delegate = (self)
        locationManagerVar.requestWhenInUseAuthorization()
        
    }
}

// MARK:- LocationManager Delegate

extension CurrentViewController: CLLocationManagerDelegate
{
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            
            print("Values are: lat: \(lat) and long: \(long)")
            
                download(lat: lat, long: long)
            
        } else {
            print("Couldn't get current coordinates")
        }
    }
    
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
     func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    
     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            
            manager.startUpdatingLocation()
        }
    }
    
}


