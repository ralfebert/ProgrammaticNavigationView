import SwiftUI

@main
struct ProgrammaticNavigationViewExampleApp: App {
    @StateObject var navModel = NavModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(self.navModel)
        }
    }
}
