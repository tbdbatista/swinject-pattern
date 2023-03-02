//
//  WeatherViewController.swift
//  SwinjectPattern
//
//  Created by Beltrami Dias Batista, Thiago on 28/02/23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var weatherService: WeatherServiceProtocol!
    lazy var weatherView = WeatherView()
    
    override func loadView() {
        view = weatherView
    }
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 64, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageContainer: UIView = {
        let imageContainer = UIImageView()
        imageContainer.backgroundColor = .cyan
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        return imageContainer
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var stack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(loadingLabel)
        NSLayoutConstraint.activate([
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        DispatchQueue.main.async {
            self.weatherService.fetchWeatherData(city: "Curitiba") { [weak self] result in
                switch result {
                case .success(let weatherResponse):
                    self?.updateUI(with: weatherResponse)
                case .failure(let error):
                    print("Error fetching weather data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func updateUI(with weatherResponse: WeatherResponse) {
        DispatchQueue.main.async { [self] in
            loadingLabel.removeFromSuperview()
            stack.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stack)
            stack.addArrangedSubview(cityLabel)
            stack.addArrangedSubview(temperatureLabel)
            stack.addArrangedSubview(descriptionLabel)
            stack.addArrangedSubview(imageContainer)
            imageContainer.addSubview(iconImage)
            stack.axis = .vertical
            stack.spacing = 16
            
            cityLabel.text = "\(weatherResponse.name)"
            temperatureLabel.text = "\(weatherResponse.main.temp)°C"
            descriptionLabel.text = "\(weatherResponse.weather[0].description)"
            iconImage.image = ImageEnum.fromCode("\(weatherResponse.weather[0].icon)")?.image
            
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
            
            NSLayoutConstraint.activate([
                iconImage.heightAnchor.constraint(equalToConstant: 55),
                iconImage.widthAnchor.constraint(equalToConstant: 60),
                iconImage.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
                iconImage.topAnchor.constraint(equalTo: imageContainer.topAnchor)
            ])

        }
    }
    
    enum ImageEnum {
        case sunMax
        case cloudSun
        case cloudRain
        case cloudFog
        case cloudBoltRain
        case cloudHeavyRain
        case notFound
        
        var imageName: String {
            switch self {
            case .sunMax:
                return "sun.max"
            case .cloudRain:
                return "cloud.rain"
            case .cloudFog:
                return "cloud.fog"
            case .cloudBoltRain:
                return "cloud.bolt.rain"
            case .cloudHeavyRain:
                return "cloud.heavy.rain"
            case .notFound:
                return "questionmark.diamond"
            case .cloudSun:
                return "cloud.sun"
            }
        }
        
        var color: UIColor {
            switch self {
            case .sunMax:
                return .systemYellow
            case .cloudRain:
                return .systemIndigo
            case .cloudFog:
                return .systemGray
            case .cloudBoltRain:
                return .systemGray
            case .cloudHeavyRain:
                return .systemIndigo
            case .notFound:
                return .systemRed
            case .cloudSun:
                return .lightGray
            }
        }
        
        var image: UIImage? {
            return UIImage(systemName: imageName)?.withTintColor(self.color, renderingMode: .alwaysOriginal)
        }
        
        static func fromCode(_ code: String) -> ImageEnum? {
            print(code)
            switch code {
            case "01d", "01n":
                return .sunMax
            case "10d", "09d":
                return .cloudRain
            case "02n", "04d", "03n", "04n":
                return .cloudFog
            case "02d", "03d":
                return .cloudSun
            case "20d":
                return .cloudBoltRain
            case "08d", "08n":
                return .cloudHeavyRain
            default:
                return .notFound
            }
        }
    }




}

