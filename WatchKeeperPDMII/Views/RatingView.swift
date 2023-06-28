import SwiftUI

struct RatingView: View {
    @Binding var userRating: Int

    var isRated: Bool {
        userRating > 0
    }

    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= userRating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        userRating = index
                    }
            }
        }
    }
}

