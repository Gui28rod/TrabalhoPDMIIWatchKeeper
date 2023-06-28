import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var movieStore: MovieStore
    @StateObject var model = MovieDetailsViewModel()
    @State private var userRating: Int = 0
    
    let movie: Movie
    let headerHeight: CGFloat = 400

    @State private var storedRating: Int = 0 // Nova propriedade para armazenar a classificação selecionada

    var isFavorite: Bool {
        movieStore.isFavorite(movie: movie)
    }

    var body: some View {
        ZStack {
            Color(red: 32/255, green: 32/255, blue: 27/255).ignoresSafeArea()

            GeometryReader { geo in
                VStack {
                    AsyncImage(url: movie.backdropURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geo.size.width, maxHeight: headerHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    } placeholder: {
                        ProgressView()
                    }
                    .overlay(
                        Rectangle()
                            .foregroundColor(Color.black.opacity(0.5))
                    )
                    .frame(maxWidth: .infinity, maxHeight: headerHeight, alignment: .center)

                }
            }

            ScrollView {
                VStack(spacing: 12) {
                    Spacer()
                        .frame(height: headerHeight)
                    HStack {
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            if isFavorite {
                                movieStore.removeFavorite(movie)
                            } else {
                                movieStore.addFavorite(movie)
                            }
                        }) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .foregroundColor(isFavorite ? .red : .primary)
                                .font(.system(size: 24))
                        }

                    }
                    HStack {
                            Text("Rating")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                            Spacer()

                           RatingView(userRating: $storedRating) // Usar a propriedade storedRating ao invés de userRating
                     
                    }

                    HStack {
                        
                        Text("About film")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Spacer()
                    }

                    Text(movie.overview)
                        .foregroundColor(.white)

                    HStack {
                        Text("Cast & Crew")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                        Spacer()
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(model.castProfiles) { cast in
                                CastView(cast: cast)
                            }
                        }
                        Spacer()
                            .frame(height: 80)
                            
                    }.foregroundColor(.gray)
                }
                .padding()
            }
        }
        .ignoresSafeArea()
       .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(.leading)
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .task {
            await model.movieCredits(for: movie.id)
            await model.loadCastProfiles()
        }
        
        //verifica se o filme já foi avaliado
        .onAppear {
            storedRating = movieStore.userRatings[movie.id] ?? 0 // Carregar a classificação do filme atual do MovieStore
        }
        .onChange(of: storedRating) { newValue in
            movieStore.userRatings[movie.id] = newValue // Atualizar a classificação no MovieStore
            movieStore.updateMovie(movie, withRating: newValue)
        }
    }

}
