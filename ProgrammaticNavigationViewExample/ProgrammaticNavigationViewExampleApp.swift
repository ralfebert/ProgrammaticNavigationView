import SwiftUI

@main
struct ProgrammaticNavigationViewExampleApp: App {
    @StateObject var navModel = NavModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(self.navModel)
        }
    }
}
