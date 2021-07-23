import SwiftUI

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
                // This is more tricky because setting the value clears the isActive value of the active NavigationLink
                // and we need to be careful to detect this case. Works but quite tricky in the details / not sure if
                // this is a good general approach.
                self.navModel.color = .blue
            }
        }
    }
}

/// Returns a Binding that is true if the value of `binding` equals `value`. If the value of the resulting binding is set, the original binding is set to value if true and to inEqualValue to false if the value of the original binding still matches the value.
public func isEqual<T: Equatable>(_ binding: Binding<T>, _ value: T, inEqualValue: T) -> Binding<Bool> {
    Binding(
        get: { binding.wrappedValue == value },
        set: { newValue in
            if newValue == true {
                binding.wrappedValue = value
            } else {
                if binding.wrappedValue == value {
                    binding.wrappedValue = inEqualValue
                }
            }
        }
    )
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
