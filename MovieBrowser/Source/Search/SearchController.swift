//
//  SearchController.swift
//  MovieBrowser
//
//  Created by Teryl S on 4/18/25.
//  Copyright © 2025 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import Combine

final class SearchController: NSObject {
    var movieClient: MovieClient?
    
    var onSearchResults: (([Movie]) -> Void)?
    var showError: ((String) -> Void)?
    var hideError: (() -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    
    func bindSearchText(_ publisher: AnyPublisher<String, Never>) {
        publisher
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink { [weak self] query in
                self?.searchMovies(query: query)
            }
            .store(in: &cancellables)
    }

    private func searchMovies(query: String) {
        movieClient?.searchMovies(search: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.onSearchResults?([])
                    self?.showError?("Failed to load movies. \((error as? ServiceError)?.errorDescription ?? "\(error.localizedDescription)")")
                }
            }, receiveValue: { [weak self] movies in
                self?.onSearchResults?(movies)
                self?.hideError?()
            })
            .store(in: &cancellables)
    }
}
