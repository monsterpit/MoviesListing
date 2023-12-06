//
//  DefaultTabView.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import SwiftUI

struct DefaultTabView: View {
    let title: String
    var body: some View {
        NavigationStack{
            Group{
                Text("\(title) is under construction ")
                + Text(Image(systemName: "hammer.fill"))
            }
            .foregroundStyle(.colorOnPrimary)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(.colorPrimary)
            .navigationBarTitle(with: title)
            
            
        }
    }
}

#Preview {
    DefaultTabView(title: "Tab 1")
}
