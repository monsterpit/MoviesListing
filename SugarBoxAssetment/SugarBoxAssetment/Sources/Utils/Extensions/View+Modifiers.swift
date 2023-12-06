//
//  View+Modifiers.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import SwiftUI

extension View{
    func navigationBarTitle(with text: String) -> some View{
        modifier(NavigationBarTitleModifier(title: text))
    }
}
