//
//  MovieListingApiService.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import Foundation

protocol MovieListingApiServiceProtocol {
    func fetchMoviesListing(pageCount: Int,perPage: Int,completion: @escaping (NetworkResult<MoviesListingResponse>) -> Void) async
}

final class MovieListingApiService: MovieListingApiServiceProtocol {

    /// The object that handles the network requests and responses.
    private let networkManager: NetworkManaging

    /// The app ID required for the server API.
    private var appID: String {
        return "3c744336870b48ab8459d3d4156fda83"
    }

    /// The key for the `appID` query parameter.
    private let appIDKey = "app_id"

    /// Initializes a new instance of the `ExchangeRateApiService` class.
    /// - Parameter networkManager: networkManager: The object that handles the network requests and responses. By default, this is set to a new instance of the `NetworkManager` class.
    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    /// Fetches exchange rates from the remote server.
    /// - Parameters:
    ///   - completion: The closure to execute when the network request is completed. The closure takes a single parameter that indicates the result of the request.
    func fetchMoviesListing(pageCount: Int,perPage: Int,completion: @escaping (NetworkResult<MoviesListingResponse>) -> Void) async{
        let queryParams = ["page": pageCount,
                           "perPage": perPage]
       await networkManager.request(MoviesListingEndPoint(queryParameters: queryParams), completion: completion)
    }
}
