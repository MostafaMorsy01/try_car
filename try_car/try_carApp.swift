//
//  try_carApp.swift
//  try_car
//
//  Created by admin on 26/01/2023.
//

import SwiftUI

@main
struct try_carApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
