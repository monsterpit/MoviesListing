//
//  SugarBoxAssetmentApp.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import SwiftUI

@main
struct SugarBoxAssetmentApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView{
                MoviesListingView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                DefaultTabView(title: "Movies")
                    .tabItem {
                        Label("Movies", systemImage: "movieclapper")
                    }
                
                DefaultTabView(title: "Shows")
                    .tabItem {
                        Label("Shows", systemImage: "play.tv")
                    }
            }
            .onAppear{
                UITabBar.appearance().unselectedItemTintColor = UIColor.gray
                UITabBar.appearance().shadowImage = UIImage()
                UITabBar.appearance().backgroundImage = UIImage()
                UITabBar.appearance().isTranslucent = true
                UITabBar.appearance().backgroundColor = .colorTetiary
                
                UINavigationBar.appearance().barTintColor = .clear
                UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
                
                URLCache.shared.memoryCapacity = 10_000_000 // ~10 MB memory space
                URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
            }
            .tint(.colorOnPrimary) //Changed for selected Tab color
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification), perform: { output in
                Reachability.stopMonitoring()
            })
        }
        
   
    }
    
    init(){
        Reachability.startMonitoring()
    }
    
}
