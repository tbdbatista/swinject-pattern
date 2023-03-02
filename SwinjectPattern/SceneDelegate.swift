//
//  SceneDelegate.swift
//  SwinjectPattern
//
//  Created by Beltrami Dias Batista, Thiago on 27/02/23.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let container = Container()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        container.register(URLSession.self) { _ in
            URLSession.shared
        }
        
        container.register(WeatherServiceProtocol.self) { resolver in
            WeatherService(session: resolver.resolve(URLSession.self)!)
        }
        
        let weatherViewController = WeatherViewController()
        weatherViewController.weatherService = container.resolve(WeatherServiceProtocol.self)
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = weatherViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}
