//
//  ContentView.swift
//  ICSCon2025_withSwiftDataAndTesting
//
//  Created by Steve Spigarelli on 8/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Prophet.prophetCalled, order: .reverse) private var prophets: [Prophet]

    var body: some View {
        NavigationSplitView {
            List(prophets) { prophet in
                NavigationLink {
                    ProphetDetailView(prophet: prophet)
                } label: {
                    HStack {
                        if let imageURL = prophet.imageUrl {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: 50, maxHeight: 50)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        Text(prophet.name)
                    }
                }
            }
            .navigationTitle("Latter-day Prophets")
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
