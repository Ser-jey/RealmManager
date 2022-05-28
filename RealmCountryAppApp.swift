//
//  RealmCountryAppApp.swift
//  Shared
//
//  Created by Сергей Кривошеев on 21.04.2022.
//

import SwiftUI

@main
struct RealmCountryAppApp: App {
  @StateObject var realmManager = RealmManager(name: "realm")
    var body: some Scene {
        WindowGroup {
            TabView{
            CountriesListView()
                    .tabItem {
                        Label("Countries",systemImage: "list.dash")
                    }
                    .environmentObject(realmManager)
                AllCitiesListView()
                    .tabItem {
                        Label("Cities", systemImage: "list.dash")
                    }
            }
            .onAppear {
                UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            }
            
        }
    }
}
