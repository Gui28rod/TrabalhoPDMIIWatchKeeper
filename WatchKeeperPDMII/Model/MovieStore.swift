import Foundation
import SwiftUI

class MovieStore: ObservableObject {
    @Published var favoriteMovies: [Movie] = []
    @Published var userRatings: [Int: Int] = [:]
    @Published var ratedMovies: [Movie] = []
    @Published var viewedMovies: [Movie] = []

    
    //Adiciona o filme como favorito
    func addFavorite(_ movie: Movie) {
        favoriteMovies.append(movie)
    }

    
    //remove o filme dos favoritos
    func removeFavorite(_ movie: Movie) {
        if let index = favoriteMovies.firstIndex(where: { $0.title == movie.title }) {
            favoriteMovies.remove(at: index)
        }
    }

    
    //Compara se já ou nao favorito
    func isFavorite(movie: Movie) -> Bool {
        return favoriteMovies.contains { $0.title == movie.title }
    }

    
    //Altera o ranting do filme
    func updateMovie(_ movie: Movie, withRating rating: Int) {
        if let index = ratedMovies.firstIndex(where: { $0.id == movie.id }) {
            ratedMovies[index] = movie
        } else {
            ratedMovies.append(movie)
        }

        userRatings[movie.id] = rating
    }

    //Adiciona rating
    func rateMovie(_ movie: Movie, rating: Int) {
        userRatings[movie.id] = rating
        ratedMovies.append(movie)
    }

    
    //Remove o rating
    func removeRating(for movieID: Int) {
        userRatings[movieID] = nil

        if let index = ratedMovies.firstIndex(where: { $0.id == movieID }) {
            ratedMovies.remove(at: index)
        }
    }

    
    //Adiciona ao historico
    func addToViewedMovies(_ movie: Movie) {
        if !viewedMovies.contains(where: { $0.id == movie.id }) {
            viewedMovies.append(movie)
        }
    }
}
