//
//  PrimoFioriApp.swift
//  PrimoFiori
//
//  Created by Doug Wade on 2/29/24.
//

import SwiftUI

@main
struct PrimoFioriApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
