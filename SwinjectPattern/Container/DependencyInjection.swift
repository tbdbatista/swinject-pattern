//
//  DependencyInjection.swift
//  SwinjectPattern
//
//  Created by Beltrami Dias Batista, Thiago on 28/02/23.
//

import Swinject
import Foundation

class DependencyInjection {
    static let shared = DependencyInjection()
    
    let container = Container()
    
    func setup() {
        container.register(URLSession.self) { _ in
            URLSession.shared
        }
        
        container.register(WeatherServiceProtocol.self) { resolver in
            WeatherService(session: resolver.resolve(URLSession.self)!)
        }
    }
}

