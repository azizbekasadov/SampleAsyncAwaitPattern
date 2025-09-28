//
//  ContentView.swift
//  SampleAsyncAwaitPattern
//
//  Created by Azizbek Asadov on 28.09.2025.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                MainContentView()
            }
        } else {
            NavigationView {
                MainContentView()
            }
        }
    }
    
    @ViewBuilder
    private func MainContentView() -> some View {
        ScrollView {
            if viewModel.isFetching {
                Text("Loading...")
                    .padding()
            } else {
                VStack {
                    ForEach(viewModel.courses) { course in
                        VStack {
                            AsyncImage(url: URL(string: course.imageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                
                            } placeholder: {
                                ProgressView()
                            }
                            
                            VStack(alignment: .leading) {
                                Text(course.name + "\n" + "Number of Lessons: \(course.numberOfLessons)")
                                    .bold()
                                Text(course.link)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .toolbar(content: {
            Button {
                Task { @MainActor in
                    await viewModel.refreshData()
                }
            } label: {
                Text("Refresh")
            }
        })
        .navigationTitle("Courses")
        .task { @MainActor in
            do {
                try await viewModel.fetchData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
