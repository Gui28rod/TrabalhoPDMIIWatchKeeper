import SwiftUI

struct DiscoverView: View {
    @StateObject var viewModel = MovieDiscoverViewModel()
    @State var searchText = ""
    @EnvironmentObject var movieStore: MovieStore
    
    var body: some View {
        NavigationView {
            ScrollView {
                if searchText.isEmpty {
                    if viewModel.trending.isEmpty {
                        Text("No Results")
                    } else {
                        VStack(spacing: 20) {
                            Text("Trending")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                            
                            ForEach(viewModel.trending) { trendingItem in
                                NavigationLink(destination: MovieDetailView(movie: trendingItem)) {
                                    TrendingCard(trendingItem: trendingItem)
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    addToHistory(trendingItem)
                                })
                            }
                        }
                        .padding()
                        .background(Color(red: 32/255, green: 27/255, blue: 27/255).ignoresSafeArea())
                    }
                } else {
                    LazyVStack {
                        ForEach(viewModel.searchResults) { item in
                            NavigationLink(destination: MovieDetailView(movie: item)) {
                                HStack {
                                    AsyncImage(url: item.backdropURL) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 120)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 80, height: 120)
                                    }
                                    .clipped()
                                    .cornerRadius(10)
                                    
                                    VStack(alignment: .leading) {
                                        Text(item.title)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        
                                        HStack {
                                            Image(systemName: "hand.thumbsup.fill")
                                            Text(String(format: "%.1f", item.vote_average))
                                            Spacer()
                                        }
                                        .foregroundColor(.yellow)
                                        .fontWeight(.heavy)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(Color(red: 61/255, green: 61/255, blue: 88/255))
                                .cornerRadius(20)
                                .padding(.horizontal)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                addToHistory(item)
                            })
                        }
                    }
                }
            }
            .background(Color(red: 32/255, green: 27/255, blue: 27/255).ignoresSafeArea())
            .searchable(text: $searchText)
            .foregroundColor(.gray)
            .tint(.red)
            .onChange(of: searchText) { newValue in
                if newValue.count > 2 {
                    viewModel.search(term: newValue)
                }
            }
            .onAppear {
                viewModel.loadTrending()
            }
        }
    }
    
    private func addToHistory(_ movie: Movie) {
        if !movieStore.viewedMovies.contains(where: { $0.id == movie.id }) {
            movieStore.viewedMovies.append(movie)
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(MovieStore())
    }
}
