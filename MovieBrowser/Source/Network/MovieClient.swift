//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import Combine

protocol MovieAPI {
    func searchMovies(search: String) -> AnyPublisher<[Movie], Error>
}

class MovieClient: MovieAPI {
    private let session: URLSession
    
    let apiBearerToken = "Bearer YOUR API KEY HERE" // pragma: allowlist-secret
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    struct MovieSearchResponse: Decodable {
        let results: [Movie]
    }
    
    
    func searchMovies(search: String) -> AnyPublisher<[Movie], Error> {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent("search/movie"), resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [URLQueryItem(name: "query", value: "\(search)")]
        
        guard let url = urlComponents.url else { return Fail(error: ServiceError.unexpectedValues).eraseToAnyPublisher() }
        
        var request = URLRequest(url: url)
        request.setValue(apiBearerToken, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw ServiceError.invalidData
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    do {
                        // Attempt to map the Json data to [Movie]
                        return try JSONDecoder().decode(MovieSearchResponse.self, from: data).results
                    } catch {
                        throw ServiceError.decodingError
                    }
                } else {
                    throw ServiceError.serverError(statusCode: httpResponse.statusCode)
                }
            }
            .mapError { error in
                switch error {
                case is URLError:
                    return ServiceError.connectivity
                case let error as ServiceError:
                    return error
                default:
                    return ServiceError.unexpectedValues
                }
            }
            .eraseToAnyPublisher()
    }
}

// Enum to represent specific errors
public enum ServiceError: Swift.Error {
    case connectivity
    case invalidData
    case unexpectedValues
    case serverError(statusCode: Int)
    case decodingError
}

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .connectivity:
            return "Please check your internet connection."
        case .invalidData:
            return "The server returned invalid data."
        case .unexpectedValues:
            return "An unexpected error occurred. Please try again."
        case .serverError(let statusCode):
            return "Server responded with an error (Status Code: \(statusCode))."
        case .decodingError:
            return "We were unable to process the movie data."
        }
    }
}
