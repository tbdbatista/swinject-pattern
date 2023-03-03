//
//  WeatherViewController.swift
//  SwinjectPattern
//
//  Created by Beltrami Dias Batista, Thiago on 28/02/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var weatherService: WeatherServiceProtocol!
    let weatherView = WeatherView()
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.weatherService.fetchWeatherData(city: "Curitiba") { [weak self] result in
                switch result {
                case .success(let weatherResponse):
                    self?.weatherView.updateUI(with: weatherResponse)
                case .failure(let error):
                    print("Error fetching weather data: \(error.localizedDescription)")
                }
            }
        }
    }
}

