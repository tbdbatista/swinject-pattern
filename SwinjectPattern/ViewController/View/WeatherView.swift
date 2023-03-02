//
//  WeatherView.swift
//  SwinjectPattern
//
//  Created by Beltrami Dias Batista, Thiago on 01/03/23.
//

import UIKit

class WeatherView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemBackground
        self.addSubview(loadingLabel)
        NSLayoutConstraint.activate([
            loadingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func updateUI(with weatherResponse: WeatherResponse) {
        DispatchQueue.main.async { [self] in
            loadingLabel.removeFromSuperview()
            stack.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(stack)
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
                stack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
                stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
            ])
            
            NSLayoutConstraint.activate([
                iconImage.heightAnchor.constraint(equalToConstant: 55),
                iconImage.widthAnchor.constraint(equalToConstant: 60),
                iconImage.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
                iconImage.topAnchor.constraint(equalTo: imageContainer.topAnchor)
            ])

        }
    }
}
