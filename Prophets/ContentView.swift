//
//  ContentView.swift
//  Prophets
//
//  Created by Steve Spigarelli on 8/12/25.
//

import Kingfisher
import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Prophet.prophetCalled, order: .reverse) private var prophets: [Prophet]

    @State private var sortAscending = false // false = newest first (matches initial .reverse)

    private var sortedProphets: [Prophet] {
        prophets.sorted { a, b in
            if sortAscending {
                return a.prophetCalled < b.prophetCalled
            } else {
                return a.prophetCalled > b.prophetCalled
            }
        }
    }

    var body: some View {
        NavigationSplitView {
            List(sortedProphets) { prophet in
                NavigationLink {
                    ProphetDetailView(prophet: prophet)
                } label: {
                    HStack {
                        KFImage(prophet.imageUrl)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 50, maxHeight: 50)
                        Text(prophet.name)
                    }
                }
            }
            .navigationTitle("Latter-day Prophets")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        sortAscending.toggle()
                    } label: {
                        // Direction reflects current order: up = oldest first, down = newest first
                        Label("Sort by Call Date", systemImage: sortAscending ? "arrow.up" : "arrow.down")
                    }
                    .help(sortAscending ? "Oldest first" : "Newest first")
                    .accessibilityLabel("Toggle sort by call date")
                }
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
        } detail: {
            Text("Select a prophet")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewSampleData.container)
}
