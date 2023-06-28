import SwiftUI

struct RatedMoviesView: View {
    @EnvironmentObject var movieStore: MovieStore

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 32/255, green: 27/255, blue: 27/255)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Spacer()
                    Text("Your Ratings")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)

                    ScrollView {
                        ForEach(movieStore.ratedMovies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                HStack {
                                    AsyncImage(url: movie.backdropURL) { image in
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
                                        Text(movie.title)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        HStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text("\n")
                                            Text("Rating: \(movieStore.userRatings[movie.id] ?? 0)")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    Spacer()
                                    Button(action: {
                                        movieStore.removeRating(for: movie.id)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                                .background(Color(red: 61/255, green: 61/255, blue: 88/255))
                                .cornerRadius(20)
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct RatedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        RatedMoviesView()
    }
}
