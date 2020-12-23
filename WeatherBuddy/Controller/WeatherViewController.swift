//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

//UITextFieldDelegate for "Go" Button when search in keyboard
class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherManager.delegate = self
        //TextField should report back to controller, when user types in text field will notify view controller
        searchTextField.delegate = self
    }

}

//MARK: - UITextFieldDelegate



extension WeatherViewController: UITextFieldDelegate {
   
    @IBAction func searchPressed(_ sender: UIButton) {
        //dismisses keyboard after search
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    //All of these are triggered by textfield class
    
    //what to do when user hits return button on keyboard, true or false to process
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //dismisses keyboard after search
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    //validation on what user types
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    //reset search bar after search
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use searchTextField.text to get weather for that city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        //Reset to empty string
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        //print(weather.temp)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }

    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
