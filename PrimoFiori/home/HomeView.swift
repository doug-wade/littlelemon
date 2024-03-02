//
//  HomeView.swift
//  PrimoFiori
//
//  Created by Doug Wade on 3/1/24.
//

import SwiftUI

struct HomeView: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView() {
            MenuView()
                .tabItem {
                    Label(
                        "Menu",
                        systemImage: "list.dash"
                    )
                }
                .environment(\.managedObjectContext, persistence.container.viewContext)
            ProfileView()
                .tabItem {
                    Label(
                        "Profile",
                        systemImage: "square.and.pencil"
                    )
                }
        }
    }
}

#Preview {
    HomeView()
}
