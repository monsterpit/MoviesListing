//
//  MoviesListingEndPoint.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.

import Foundation

struct MoviesListingEndPoint: Endpoint {

    var httpMethod: HTTPMethod { .get }
    var queryParameters: [String: Any]?
    var baseURL: URL = URL(string: "https://apigw.sboxdc.com/")!
    let path: String = "ecm/v2/super/feeds/zee5-home/details"

    init(queryParameters: [String: Any]?) {
        self.queryParameters = queryParameters
    }

}
