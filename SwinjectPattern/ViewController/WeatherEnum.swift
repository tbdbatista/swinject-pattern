//
//  WeatherEnum.swift
//  SwinjectPattern
//
//  Created by Beltrami Dias Batista, Thiago on 02/03/23.
//

import UIKit

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

