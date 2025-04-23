//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class SearchViewController: UIViewController {
    
    var movieClient: MovieAPI = MovieClient()
    
    @IBOutlet var searchController: SearchController?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var errorView: UIView?
    @IBOutlet var errorLabel: UILabel?
    @IBOutlet var errorViewHeight: NSLayoutConstraint?
    
    @Published private var searchText: String = ""
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        hideError()
        
        searchController?.movieClient = movieClient
        
        searchController?.onSearchResults = { [weak self] movies in
            self?.movies = movies
            self?.tableView.reloadData()
        }
        searchController?.showError = { [weak self] message in
            self?.showError(message)
        }
        searchController?.hideError = { [weak self] in
            self?.hideError()
        }
        
        searchController?.bindSearchText($searchText.eraseToAnyPublisher())
    }
    
    private func showError(_ message: String) {
        errorLabel?.text = message
        errorView?.isHidden = false
        errorViewHeight?.constant = 44
    }

    private func hideError() {
        errorView?.isHidden = true
        errorViewHeight?.constant = 0
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MovieTableCell else {
            return UITableViewCell()
        }
        cell.title.text = movie.title
        if let releaseDate = DateFormatter.apiFormatter.date(from: movie.release_date) {
            cell.releaseDate.text = DateFormatter.displayFormatter.string(from: releaseDate)
        }
        cell.score.text = String(format: "%.1f", movie.popularity)
      
        if let url = movie.posterURL {
            cell.movieThumb.loadImage(url: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovie = movies[indexPath.row]
        let detailView = DetailView(movie: selectedMovie)

        let detailVC = UIHostingController(rootView: detailView)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}

class ImageLoader: UIImageView {
    var task: URLSessionTask!
    
    func loadImage(url: URL) {
        task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        task.resume()
    }
}
