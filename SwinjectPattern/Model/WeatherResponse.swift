//
//  WeatherResponse.swift
//  SwinjectPattern
//
//  Created by Beltrami Dias Batista, Thiago on 28/02/23.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Coordinate
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let dt: TimeInterval
    let sys: System
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double?
    let tempMin: Int?
    let tempMax: Int?
    let pressure: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

struct System: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: TimeInterval
    let sunset: TimeInterval
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

