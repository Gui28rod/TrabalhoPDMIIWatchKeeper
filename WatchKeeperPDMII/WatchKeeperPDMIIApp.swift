import SwiftUI

@main
struct WatchKeeperPDMII: App {
    @StateObject private var movieStore = MovieStore()
    @State private var showTabView = false


    var body: some Scene {
        WindowGroup {
            if showTabView {
                TabView {
                    DiscoverView()
                        .environmentObject(movieStore) // Adicione o MovieStore como um objeto ambiental
                        .tabItem {
                            Image(systemName: "popcorn")
                            Text("Movies")
                        }.background(Color.white)
                    LikesView() // Use a nova view para exibir os filmes favoritos
                        .environmentObject(movieStore) // Adicione o MovieStore como um objeto ambiental
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("Favorites")
                        }.background(Color.white)
                    RatedMoviesView()
                          .environmentObject(movieStore)
                          .tabItem {
                              Image(systemName: "star")
                              Text("Rated")
                          }.background(Color.white)
                    HistoryView()
                          .environmentObject(movieStore)
                          .tabItem {
                              Image(systemName: "clock.arrow.circlepath")
                              Text("Historic")
                          }.background(Color.white)
                }
            } else {
                IntroductionView(showTabView: $showTabView)
                    .environmentObject(movieStore) // Adicione o MovieStore como um objeto ambiental
            }
        }
    }
}
