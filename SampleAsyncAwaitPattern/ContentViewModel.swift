//
//  ContentViewModel.swift
//  SampleAsyncAwaitPattern
//
//  Created by Azizbek Asadov on 28.09.2025.
//

import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
    @Published var isFetching = false
    @Published var courses: [Course] = []
    
    private let networkService = NetworkService()
    
    func fetchData() async throws {
        self.isFetching = true
        self.courses = try await networkService.fetchData()
        self.isFetching = false
    }
    
    func refreshData() async {
        withAnimation {
            self.courses.removeAll()
            self.isFetching = true
        }
        
        do {
            try await fetchData()
        } catch {
            print(error.localizedDescription)
        }
    }
}
