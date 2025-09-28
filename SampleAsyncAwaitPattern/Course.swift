//
//  Course.swift
//  SampleAsyncAwaitPattern
//
//  Created by Azizbek Asadov on 28.09.2025.
//

import Foundation

struct Course: Decodable, Identifiable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    let numberOfLessons: Int
}
