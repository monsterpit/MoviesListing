//
//  MoviesListingView.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import SwiftUI

struct MoviesListingView: View {
    @StateObject private var viewModel = MovieListingViewModel()
    
    var body: some View{
        NavigationStack{
            ZStack{
                ScrollView{
                    LazyVStack{
                        ForEach(viewModel.movieWidgets){ movieWidget in
                            Group{
                                switch movieWidget{
                                case .carousel(let imageURLs):
                                    SnapCarouselView(index: $viewModel.currentIndex, items: imageURLs,showIndicator: true){ imageURL in
                                        GeometryReader{ proxy in
                                            AsyncImage(url: imageURL) { imagePhase in
                                                if let image = imagePhase.image{
                                                    image.resizable()
                                                        .scaledToFill()
                                                        .frame(width: proxy.size.width)
                                                        .cornerRadius(12)
                                                }else{
                                                    Image(.placeHolder)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: proxy.size.width)
                                                        .cornerRadius(12)
                                                }
                                            }
                                       
                                        }
                                    }
                                    .padding(.vertical,10)
                                case .ott(let title,let imageURLs):
                                    Carousel2DView(title: title,imageURLs: imageURLs)
                                        .padding(.leading)
                                }
                            }
                            .task{
                                if viewModel.movieWidgets.last == movieWidget{
                                    await viewModel.fetchMoviesListing()
                                }
                            }
                        }
                    }
                    
                }
                .disabled(viewModel.loadingState)
                .task{
                    await viewModel.fetchMoviesListing()
                }
                .scrollBounceBehavior(.basedOnSize)
                .background(.colorPrimary)
                .navigationBarTitle(with: "Sugarbox") //Custom Modifier
                
                if viewModel.loadingState{
                        ProgressView()
                }
            }
        }
    }
    
}


#Preview {
    MoviesListingView()
}
