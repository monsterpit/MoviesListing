//
//  MovieListingViewModel.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import Foundation

@MainActor
protocol MovieListingViewModelProtocol: ObservableObject {
    var loadingState: Bool { get }
    var movieWidgets: [MovieWidget] {get }
    var currentIndex: Int {get set}
    func fetchMoviesListing() async
}

@MainActor class MovieListingViewModel: ObservableObject,MovieListingViewModelProtocol{
    
    @Published private(set) var movieWidgets: [MovieWidget] = []
    
    @Published private(set) var loadingState: Bool = false
    
    @Published var currentIndex = 0
    
    private var pageCount = 1
    private var perPage = 20
    private var totalCount: Int?
    
    /// The repository object responsible for communicating with the movies  API.
    private let repository: MovieListingRepositoryProtocol
    
    /// Initializes the view model with a repository object.
    /// - Parameter repository: The repository object responsible for communicating with the movies  API.
    init(repository: MovieListingRepositoryProtocol = MovieListingRepositoryRepository()) {
        self.repository = repository
    }
    
    // Fetches the Movie lists
    func fetchMoviesListing() async{
        guard  !loadingState ,totalCount != movieWidgets.count else{ return }
        loadingState = true
        await repository.fetchMoviesListing (pageCount: pageCount,perPage: perPage){ [weak self] (result: NetworkResult<MoviesListingResponse>) in
            guard let self else {
                return
            }
            Task{
                await MainActor.run{
                    switch result {
                    case .success(let movieList):
                        self.pageCount += 1
                        self.totalCount = movieList.pagination.totalCount
                        self.movieWidgets.append(contentsOf: movieList.movieWidgets)
                    case .failure(let error):
                        print("Error fetching exchange rates \(error.localizedDescription)")
                    }
                    self.loadingState = false
                }
            }
        }
    }
}
