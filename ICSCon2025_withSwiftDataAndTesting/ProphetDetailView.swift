import SwiftUI

struct ProphetDetailView: View {
    let prophet: Prophet

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = prophet.imageUrl {
                    HStack {
                        Spacer()
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200, maxHeight: 200)
                        } placeholder: {
                            ProgressView()
                        }
                        Spacer()
                    }
                }
                Group {
                    Text("Born: \(formatDate(prophet.born))")
                    if let died = prophet.died {
                        Text("Died: \(formatDate(died))")
                    }
                    if let apostleCalled = prophet.apostleCalled {
                        Text("Apostle Called: \(formatDate(apostleCalled))")
                    }
                    Text("Prophet Called: \(formatDate(prophet.prophetCalled))")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                if !prophet.notableQuotes.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notable Quotes")
                            .font(.headline)
                        ForEach(prophet.notableQuotes, id: \ .self) { quote in
                            HStack(alignment: .top) {
                                Text("•")
                                Text(quote)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .padding()
        }
        .navigationTitle(prophet.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
//    ProphetDetailView(prophet: PreviewSampleData.prophet)
}
