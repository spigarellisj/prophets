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
            Prophet.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let context = container.mainContext

            // Check if database is empty for Prophets
            let fetchDescriptor = FetchDescriptor<Prophet>()
            let count = (try? context.fetchCount(fetchDescriptor)) ?? 0
            if count == 0 {
                // Load prophets.json
                if let url = Bundle.main.url(forResource: "prophets", withExtension: "json"),
                   let data = try? Data(contentsOf: url),
                   let jsonArray = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    for dict in jsonArray {
                        guard let name = dict["name"] as? String,
                              let bornStr = dict["born"] as? String,
                              let prophetCalledStr = dict["prophetCalled"] as? String,
                              let notableQuotes = dict["notableQuotes"] as? [String],
                              let imageUrl = dict["imageUrl"] as? String else { continue }

                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        guard let born = dateFormatter.date(from: bornStr),
                              let prophetCalled = dateFormatter.date(from: prophetCalledStr) else { continue }

                        let died: Date? = (dict["died"] as? String).flatMap { dateFormatter.date(from: $0) }
                        let apostleCalled: Date? = (dict["apostleCalled"] as? String).flatMap { dateFormatter.date(from: $0) }

                        let prophet = Prophet(
                            name: name,
                            born: born,
                            died: died,
                            apostleCalled: apostleCalled,
                            prophetCalled: prophetCalled,
                            imageUrl: imageUrl,
                            notableQuotes: notableQuotes
                        )
                        context.insert(prophet)
                    }
                    try? context.save()
                }
            }
            return container
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
