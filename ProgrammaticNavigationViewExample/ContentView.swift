import SwiftUI
import SwiftUIBindingTransformations

enum NavColor: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case red, green, blue
}

class NavModel: ObservableObject {
    @Published var color: NavColor?
}

struct ContentView: View {
    @EnvironmentObject var navModel: NavModel

    var body: some View {
        List {
            ForEach(NavColor.allCases) { navColor in
                NavigationLink(
                    isActive: isEqual(self.$navModel.color, navColor, inEqualValue: nil),
                    destination: {
                        ColorView(navColor: navColor)
                    },
                    label: {
                        Text(navColor.rawValue)
                    }
                )
            }

            Button("Random color") {
                self.navModel.color = NavColor.allCases.randomElement()!
            }
        }
        .navigationTitle("Example")
    }
}

struct ColorView: View {
    @State var special = false
    let navColor: NavColor

    var body: some View {
        ZStack {
            self.backgroundView
                .ignoresSafeArea()
            NavigationLink("Show special") {
                SpecialView()
            }
        }
    }

    @ViewBuilder var backgroundView: some View {
        switch self.navColor {
        case .red:
            Color.red
        case .green:
            Color.green
        case .blue:
            Color(red: 0, green: 0, blue: 0.5)
        }
    }
}

struct SpecialView: View {
    @EnvironmentObject var navModel: NavModel

    var body: some View {
        VStack(spacing: 10) {
            Text("Todays special is: ...")

            Button("Go back") {
                self.navModel.color = nil
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
