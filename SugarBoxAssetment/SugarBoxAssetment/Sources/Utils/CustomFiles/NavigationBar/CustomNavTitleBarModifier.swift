//
//  CustomNavTitleBarModifier.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import SwiftUI

struct NavigationBarTitleModifier: ViewModifier{
    var title: String
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.colorPrimary,for: .navigationBar)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.colorOnPrimary)
                }
            }
    }
}
