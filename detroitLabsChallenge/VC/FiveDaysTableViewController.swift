//
//  FiveDaysTableViewController.swift
//  detroitLabsChallenge
//
//  Created by may on 2018-06-08.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import UIKit
import CoreLocation

class FiveDaysTableViewController: UITableViewController {

    // MARK:- Outlets
    
    let locationVar = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
    }
    
    func download(lat: Double, long: Double) {
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&APPID=\(Constants.API_KEY)")
        
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
                
                print(todo.name)
                
                //                 Mathmetical Equation to convert K to F
                var faher = ((todo.main.temp * (9/5)) - 459.67)
                //                 Round the result to 2 digits only
                faher.round()
                
                //                 assign them to new vars
//                self.nameOfCity = todo.name
//                self.currentTemp = String(faher)
//                self.iconCode = todo.weather[0].icon
                
            } catch {
                print("error trying to convert data to JSON in URLsession taks func")
            }
            
            DispatchQueue.main.async {
                
//                self.currentTempLabel.text = self.currentTemp
//                self.currentCityOutlet.text = self.nameOfCity
                
//                guard let url = URL(string: "http://openweathermap.org/img/w/\(self.iconCode).png") else {
//                    print("url not working")
//                    return
//                }
//
//                let downloadedImage = try? UIImage(data: Data(contentsOf: url))
//
//                if let downloadedImage = downloadedImage {
//                    self.CurrentWeatherimageView.image = downloadedImage
//                }
                
            }
            
            }.resume()
        
        //("reached end of URL session func")
    }
    

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FiveDaysTableViewController: CLLocationManagerDelegate
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
