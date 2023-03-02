//
//  WeatherService.swift
//  SwinjectPattern
//
//  Created by Beltrami Dias Batista, Thiago on 28/02/23.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeatherData(city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
    var session: URLSession { get }
}

class WeatherService: WeatherServiceProtocol {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchWeatherData(city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        let apiKey = ENV.WEATHER_API_KEY
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let safeData = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                return
            }
            completion(self.parseJSON(safeData))
        }
        
        task.resume()
    }
    
    private func parseJSON(_ data: Data) -> Result<WeatherResponse, Error> {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            return .success(weatherResponse)
        } catch let error as DecodingError {
            print("Decoding error: \(error)")
            return .failure(error)
        } catch let error {
            print("Error decoding JSON: \(error.localizedDescription)")
            return .failure(error)
        }
        
    }
}
