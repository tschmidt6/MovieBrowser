//
//  DetailView.swift
//  MovieBrowser
//
//  Created by Becker, Andrew on 3/13/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let movie: Movie
    
    
    var body: some View {
        VStack {
            Text(movie.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            
            Text("release Date: \(movie.release_date)")
                .font(.subheadline)
            
            HStack {
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Image("placeholder")
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                
                Text(movie.overview)
                    .font(.body)
            }
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: Movie(id: 0, title: "Squid Game: Fireplace", release_date: "2024-12-12", popularity: 7.6, overview: "Come share a toast in the Front Man\'s lair — but tread carefully, for you’re playing with fire.", poster_path: ""))
    }
}

// MARK: - Date Formatting
extension DateFormatter {
    static let displayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }()
    static let apiFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
