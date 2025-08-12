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
}
