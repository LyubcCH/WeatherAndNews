//
//  WeatherViewController.swift
//  TheNewsApp
//
//  Created by Lyub Chibukhchian on 7/25/19.
//  Copyright © 2019 Lyub Chibukhchian. All rights reserved.
//

import UIKit

struct Weather {
    var temperature: Double
    var condition: Int
}


class WeatherViewController: UIViewController {

    let weatherURL = "https://openweathermap.org/data/2.5/weather?q="
    let appID = "&appid=b6907d289e10d714a6e88b30761fae22"
    
    var weather: Weather = Weather(temperature: 0, condition: 0)
    
    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var temperatureLabel: UILabel!
    
    @IBOutlet var weatherImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func goToMainPageButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func getWeatherButtonTapped(_ sender: UIButton) {
        
        
        let url = URL(string: weatherURL + cityTextField.text! + appID)!

        URLSession.shared.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }


            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])

                guard let jsonArray = json as? [String: Any] else {
                    return
                }
                print(jsonArray)
               
                  guard let main_info = jsonArray["main"]! as? [String: Double] else { return }
                  print(main_info)
                guard let weather_info = jsonArray["weather"] as? [[String: Any]] else { return }
                
                  self.weather.temperature = main_info["temp"]!
                self.weather.condition = weather_info[0]["id"]! as! Int
                 print(self.weather.temperature)
                print(self.weather.condition)
                DispatchQueue.main.async {
                    self.temperatureLabel.text = String(self.weather.temperature)
                    self.weatherImageView.image = UIImage(named: self.updateWeatherIcon(condition: self.weather.condition))
                    
                }
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }.resume()
    }
    

    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }

  

}
