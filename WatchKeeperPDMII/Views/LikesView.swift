import SwiftUI

struct LikesView: View {
    @EnvironmentObject var movieStore: MovieStore

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 32/255, green: 27/255, blue: 27/255)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Spacer()
                    Text("Your Favorites")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)

                    ScrollView {
                        ForEach(movieStore.favoriteMovies) { item in
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
                                        Spacer()
                                        Text(item.title)
                                            .foregroundColor(.white)
                                            .font(.headline)

                                        

                                        HStack {
                                            Image(systemName: "hand.thumbsup.fill")
                                                .foregroundColor(.yellow)
                                                .fontWeight(.heavy)
                                            Text(String(format: "%.1f", item.vote_average))
                                                .foregroundColor(.yellow)
                                                .fontWeight(.heavy)
                                            Spacer()
                                            Image(systemName:"heart.fill")
                                                .foregroundColor(.red)
                                                .font(.system(size: 21))
                                        }

                                        Spacer()
                                        
                                            

                                    }
                                    Spacer()
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

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView()
    }
}
