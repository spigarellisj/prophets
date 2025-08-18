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
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Item.self, configurations: config)
    
            // Add sample data
            let context = container.mainContext
            for i in 1...5 {
                let item = Item(timestamp: Date().addingTimeInterval(-3600 * Double(i)))
                context.insert(item)
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
