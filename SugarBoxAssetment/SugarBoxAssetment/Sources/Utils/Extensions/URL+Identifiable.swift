//
//  URL+Identifiable.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import Foundation

extension URL: Identifiable{
    public var id: Self{
        return self
    }
}
