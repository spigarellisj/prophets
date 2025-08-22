import Kingfisher
import SwiftUI

struct ProphetDetailView: View {
    let prophet: Prophet

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    KFImage(prophet.imageUrl)
                        .resizable()
                        .roundCorner(radius: .widthFraction(0.1))
                        .scaledToFit()
                        .frame(maxWidth: 200, maxHeight: 200)
                    Spacer()
                }
                Group {
                    dateField(text: "Born", date: prophet.born)
                    dateField(text: "Died", date: prophet.died)
                    dateField(text: "Call date to the Quorum of the Twelve Apostles", date: prophet.apostleCalled)
                    dateField(text: "Call date as President of the Church of Jesus Christ of Latter-day Saints", date: prophet.prophetCalled)
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
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
    
    @ViewBuilder
    private func dateField(text: String, date: Date?) -> some View {
        if let date {
            HStack(alignment: .top) {
                Text(text)
                Spacer()
                Text(date, style: .date)
            }
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    ProphetDetailView(prophet: PreviewSampleData.prophet)
}
