//
//  BaseEnv.swift
//  SwinjectPattern
//
//  Created by Beltrami Dias Batista, Thiago on 01/03/23.
//

import Foundation
import UIKit

class BaseEnv {
    
    let dict: NSDictionary
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.url(forResource: resourceName, withExtension: "plist"),
              let plist = NSDictionary(contentsOf: filePath)
        else {
            fatalError("Couldn't find file \(resourceName).plist")
        }
        self.dict = plist
    }
    
    enum Key: String {
        case WEATHER_API_KEY
    }
    
    enum EnvInfo: String {
        case Debug_Api_Info
        case Prod_Api_Info
    }
}

protocol EnvAPIKeys {
    var WEATHER_API_KEY: String {get}
}

class DebugEnv: BaseEnv, EnvAPIKeys {
    var WEATHER_API_KEY: String {
        dict.object(forKey: Key.WEATHER_API_KEY.rawValue) as? String ?? ""
    }
    
    init() {
        super.init(resourceName: EnvInfo.Debug_Api_Info.rawValue)
    }
}

class ProdEnv: BaseEnv, EnvAPIKeys {
    var WEATHER_API_KEY: String {
        dict.object(forKey: Key.WEATHER_API_KEY.rawValue) as? String ?? ""
    }
    
    init() {
        super.init(resourceName: EnvInfo.Prod_Api_Info.rawValue)
    }
}

var ENV: EnvAPIKeys {
    #if DEBUG
    return DebugEnv()
    #else
    return ProdEnv()
    #endif
}
