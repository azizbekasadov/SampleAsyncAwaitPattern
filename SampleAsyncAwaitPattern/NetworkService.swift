//
//  NetworkService.swift
//  SampleAsyncAwaitPattern
//
//  Created by Azizbek Asadov on 28.09.2025.
//

import Foundation

let baseURL = "https://api.letsbuildthatapp.com/jsondecodable/courses"

actor NetworkService {
    
    func fetchData<T: Decodable>() async throws -> [T] {
        guard let url = await URL(string: baseURL) else {
            return []
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            return try JSONDecoder().decode([T].self, from: data)
        } else {
            throw NSError(domain: Bundle.main.bundleIdentifier!, code: -999)
        }
    }
}
