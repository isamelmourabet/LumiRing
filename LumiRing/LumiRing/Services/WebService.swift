//
//  WebService.swift
//  LumiRing
//
//  Created by Isam El Mourabet on 18/8/25.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case badURL
}

class WebService {
    
    func openDoor() async throws {
        guard let url = URL(string: "https://lumiring-production.up.railway.app/api/openDoor") else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
    }
    
    func checkDoor() async throws -> Bool {
        guard let url = URL(string: "https://lumiring-production.up.railway.app/api/openDoor") else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        // Decodificamos un simple boolean
        guard let isOpen = try? JSONDecoder().decode(Bool.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return isOpen
    }
    
    func checkRing() async throws -> Bool {
        guard let url = URL(string: "https://lumiring-production.up.railway.app/api/ring") else {
            throw NetworkError.badURL
        }
        
        let(data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let isRing = try? JSONDecoder().decode(Bool.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return isRing
    }
    
    
    func getStatus() async throws -> String {
        guard let url = URL(string: "https://lumiring-production.up.railway.app/api/status") else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let status = String(data: data, encoding: .utf8) else {
            throw NetworkError.decodingError
        }
        
        return status
    }
}
