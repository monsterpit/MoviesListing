//
//  MoviesListingModel.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import Foundation

enum MovieWidget: Hashable,Identifiable{
    var id: Self {
         return self
     }
    
    case carousel(imageURL: [URL])
    case ott(title: String,imageURL: [URL])
}

struct MoviesListingResponse: Codable{
    let data: [MoviesWidget]
    let pagination: MoviePagination
    
    //MARK: Computed Property to directly get the type and data required
    var movieWidgets: [MovieWidget] {
        var widgets: [MovieWidget]  = []
        for movieData in data{
            switch movieData.designSlug{
            case .carousal:
                let imageURLs = movieData.contents.map{$0.image}
                widgets.append(.carousel(imageURL: imageURLs))
            case .ott:
                let title = movieData.title
                let imageURLs = movieData.contents.map{$0.image}
                widgets.append(.ott(title: title,imageURL: imageURLs))
            case .unknown:
                break
            }
        }
        return widgets
    }
}

enum MovieWidgetDesign: String, Codable{
    case carousal  = "CarousalWidget"
    case ott = "OTTWidget"
    case unknown = "unknown"

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self = MovieWidgetDesign(rawValue: string) ?? .unknown
    }
}

struct MoviesWidget: Codable{
    let title: String
    let designSlug: MovieWidgetDesign
    let contents: [Movie]
}

struct Movie: Codable{
    let assets: [MovieAsset]
    
    //MARK: Computed property to get imageURL by changing the base URL
    var image: URL{
        if let imageURLString = (assets.first{$0.assetType == .image })?.sourceUrl,
        let url = URL(string: imageURLString),
        let newURL = URL(string: "https://static01.sboxdc.com/images"){
            let path = url.path
            return newURL.appendingPathComponent(path)
        }
        return URL(string: "")!
    }
}

enum MovieAssetDesign: String, Codable{
    case image  = "IMAGE"
    case video = "VIDEO"
}

struct MovieAsset: Codable{
    let assetType: MovieAssetDesign
    let sourceUrl: String
}



struct MoviePagination: Codable{
    let totalCount: Int
}
