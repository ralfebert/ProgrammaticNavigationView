import SwiftUI

enum CardSuit: String, CaseIterable {
    case diamonds
    case clubs
    case hearts
    case spades
}

class NavModel: ObservableObject {
    @Published var activeSuit: CardSuit? {
        didSet {
            print("activeSuit: ", String(describing: self.activeSuit))
        }
    }

    @Published var showDetails = false {
        didSet {
            print("showDetails: ", self.showDetails)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var navModel: NavModel

    var body: some View {
        List {
            ForEach(CardSuit.allCases, id: \.self) { suit in
                NavigationLink(
                    tag: suit,
                    selection: $navModel.activeSuit,
                    destination: {
                        SuitView(suit: suit)
                    },
                    label: {
                        Text(suit.rawValue)
                    }
                )
            }
        }
        .navigationTitle("Card suits")
    }
}

struct SuitView: View {
    @EnvironmentObject var navModel: NavModel
    let suit: CardSuit

    var body: some View {
        VStack(spacing: 10) {
            Text(suit.rawValue)

            NavigationLink(
                isActive: $navModel.showDetails,
                destination: {
                    DetailsView(suit: suit)
                },
                label: {
                    Text("Show more details")
                }
            )
        }
    }
}

struct DetailsView: View {
    @EnvironmentObject var navModel: NavModel
    let suit: CardSuit

    var body: some View {
        VStack(spacing: 10) {
            Text("More details about \(suit.rawValue)")

            Button("Go back to suit") {
                self.navModel.showDetails = false
            }
            Button("Go back to suit menu") {
                self.navModel.activeSuit = nil
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
