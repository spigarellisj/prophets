//
//  PreviewModelContainer.swift
//  ICSCon2025_withSwiftDataAndTesting
//
//  Created by Steve Spigarelli on 8/12/25.
//

import Foundation
import SwiftData

@MainActor
struct PreviewSampleData {
    static var container: ModelContainer = {
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
            fatalError("Failed to create preview container: \(error)")
        }
    }()
    
    static let prophet: Prophet = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return Prophet(
            name: "Russell M. Nelson",
            born: formatter.date(from: "1924-09-09")!,
            died: nil,
            apostleCalled: formatter.date(from: "1984-04-07"),
            prophetCalled: formatter.date(from: "2018-01-14")!,
            imageUrl: "https://www.churchofjesuschrist.org/imgs/c5095c402a6d565be72ac46ffda6615ffe88ec5f/full/640%2C/0/default",
            notableQuotes: [
                "The temple is the house of the Lord.",
                "The gospel of Jesus Christ is the power of God unto salvation.",
                "The Lord will always be with His people, and He will always sustain them if they will only be faithful to Him."
            ]
        )
    }()
}
