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
    var movieClient: MovieAPI?
    
    var onSearchResults: (([Movie]) -> Void)?
    var resetSearch: (() -> Void)?
    var showError: ((String) -> Void)?
    var hideError: (() -> Void)?
    
    var currentPage = 1
    var isLoading = false
    var hasMorePages = true
    var lastQuery: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func bindSearchText(_ publisher: AnyPublisher<String, Never>) {
        publisher
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink { [weak self] query in
                if self?.lastQuery != query {
                    self?.currentPage = 1
                    self?.resetSearch?()
                }
                self?.lastQuery = query
                self?.searchMovies(query: query)
            }
            .store(in: &cancellables)
    }
    
    func requestNextPage() {
        guard hasMorePages else { return }
        guard let search = lastQuery else { return }
        searchMovies(query: search)
    }

    private func searchMovies(query: String) {
        guard !isLoading else { return }
        
        isLoading = true
        
        movieClient?.searchMovies(search: query, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.onSearchResults?([])
                    self?.showError?("Failed to load movies. \((error as? ServiceError)?.errorDescription ?? "\(error.localizedDescription)")")
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] result in
                if result.page < result.total_pages {
                    self?.hasMorePages = true
                    self?.currentPage = result.page + 1
                } else {
                    self?.hasMorePages = false
                }
                self?.onSearchResults?(result.results)
                self?.hideError?()
                self?.isLoading = false
                
            })
            .store(in: &cancellables)
    }
}
