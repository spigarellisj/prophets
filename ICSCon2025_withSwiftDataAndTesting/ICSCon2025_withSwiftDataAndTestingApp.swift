//
//  ICSCon2025_withSwiftDataAndTestingApp.swift
//  ICSCon2025_withSwiftDataAndTesting
//
//  Created by Steve Spigarelli on 8/12/25.
//

import SwiftUI
import SwiftData

@main
struct ICSCon2025_withSwiftDataAndTestingApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
