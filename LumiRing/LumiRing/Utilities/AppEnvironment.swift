//
//  AppEnvironment.swift
//  LumiRing
//
//  Created by Isam El Mourabet on 18/8/25.
//

import Foundation

enum Endpoints {
    case ring
    case openDoor
    
    var path: String {
        switch self {
            case .ring:
                return "/api/ring"
            case .openDoor:
                return "/api/open-door"
        }
    }
}


enum AppEnvironment: String {
    case dev
    case test
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://lumiring.up.railway.app")!
        case .test:
            // Empty, no test URL available
            return URL(string: "")!
        }
    }
}
