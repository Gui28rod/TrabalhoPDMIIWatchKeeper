import SwiftUI

struct TrendingCard: View {
    let trendingItem: Movie
    @EnvironmentObject var movieStore: MovieStore

    var isFavorite: Bool {
        movieStore.isFavorite(movie: trendingItem)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Imagem do filme em destaque
            AsyncImage(url: trendingItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 240)
            } placeholder: {
                Color(red: 61/255, green: 61/255, blue: 88/255)
                    .frame(width: 340, height: 240)
            }
            .cornerRadius(10)
            .frame(width: 340, height: 250)

            VStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer()
                    // Botão de favorito
                    Button(action: {
                        if isFavorite {
                            movieStore.removeFavorite(trendingItem)
                        } else {
                            movieStore.addFavorite(trendingItem)
                            
                        }
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .foregroundColor(isFavorite ? .red : .primary)
                            .font(.system(size: 21))
                    }
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text(String(format: "%.1f", trendingItem.vote_average))
                    Spacer()
                }
                .foregroundColor(.yellow)
                .fontWeight(.heavy)
            }
            .padding()
            .background(Color(red: 116/255, green: 63/255, blue: 125/255))
        }
    }
}
