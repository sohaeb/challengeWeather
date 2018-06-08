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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
}

//-----------------------------------------------------//

// MARK:- LocationManager Delegate

extension CurrentViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            
            print("Values are: lat: \(lat) and long: \(long)")
            
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


