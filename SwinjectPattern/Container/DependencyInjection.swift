//
//  DependencyInjection.swift
//  SwinjectPattern
//
//  Created by Beltrami Dias Batista, Thiago on 28/02/23.
//

import Swinject
import UIKit

class DependencyInjection {
    static let shared = DependencyInjection()
    
    let container = Container()
    
    func resolveDependencyInjection(){
        container.register(URLSession.self) { _ in
            URLSession.shared
        }
        
        container.register(WeatherServiceProtocol.self) { resolver in
            WeatherService(session: resolver.resolve(URLSession.self)!)
        }
        
        container.register(WeatherViewController.self) { resolver in
            WeatherViewController(weatherService: resolver.resolve(WeatherServiceProtocol.self)!)
        }
    }

}

