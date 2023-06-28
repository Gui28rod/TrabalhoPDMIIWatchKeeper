import Foundation

@MainActor
class MovieDiscoverViewModel: ObservableObject{

    @Published var trending: [Movie] = []
    @Published var searchResults: [Movie] = []

    static let apiKey = "3c952097daa15b6c9063b05d3b526eb2"


    //Vai buscar os valores à API e faz o decode deles
    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDiscoverViewModel.apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func search(term: String) {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US&page=1&include_adult=false&query=\(term)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let searchResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                let sortedMovies = searchResults.results.sorted(by: { $0.vote_average > $1.vote_average })
                self.searchResults = sortedMovies
            } catch {
                print(error.localizedDescription)
            }
        }
    }





}
