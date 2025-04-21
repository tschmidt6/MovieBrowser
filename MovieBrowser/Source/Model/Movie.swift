//
//  Movie.swift
//  MovieBrowser
//
//  Created by Teryl S on 4/14/25.
//  Copyright © 2025 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
    let id: Int
    let title: String
    let release_date: String
    let popularity: Double
    let overview: String
    let poster_path: String?
    
    var posterURL: URL? {
        guard let path = poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(path)")
    }
}
