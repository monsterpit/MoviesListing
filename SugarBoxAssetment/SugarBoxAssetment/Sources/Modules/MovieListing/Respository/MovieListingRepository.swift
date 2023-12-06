//
//  MovieListingRepository.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import Foundation

protocol MovieListingRepositoryProtocol {
    func fetchMoviesListing(pageCount: Int,perPage: Int,completion: @escaping (NetworkResult<MoviesListingResponse>) -> Void) async
}

final class MovieListingRepositoryRepository: MovieListingRepositoryProtocol {
    private let apiService: MovieListingApiServiceProtocol

    /// Initializes a new instance of the `ExchangeRateRepository` class with the specified `ExchangeRateApiServiceProtocol` instance.
    /// - Parameter apiService: An instance of `ExchangeRateApiServiceProtocol`.
    init(apiService: MovieListingApiServiceProtocol = MovieListingApiService()) {
        self.apiService = apiService
    }

    /// Fetches the currency exchange rates based on the given amount.
    /// - Parameters:
    ///   - amount: A `Double` value representing the amount to exchange.
    ///   - completion: A completion block that will be called when the API call finishes, returning a `NetworkResult` object containing either the fetched `MoviesList` or an error.
    func fetchMoviesListing(pageCount: Int,perPage: Int,completion: @escaping (NetworkResult<MoviesListingResponse>) -> Void) async{
        await apiService.fetchMoviesListing(pageCount: pageCount,perPage: perPage,completion: completion)
    }
}
