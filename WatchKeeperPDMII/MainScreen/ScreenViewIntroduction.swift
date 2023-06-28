import SwiftUI

struct IntroductionView: View {
    @Binding var showTabView: Bool
    
    var body: some View {
        ZStack {
            Color(red: 32/255, green: 32/255, blue: 27/255).ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer(minLength: 100)
                
                Image("FILMESKEEPER")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .position(x:195,y:200)
                    .onTapGesture {
                        showTabView = true
                    }
                
                Spacer()
                
                Button("WATCHKEEPER") {
                    showTabView = true
                }
                .foregroundColor(Color(red: 207/255, green: 157/255, blue: 52/255))
                .position(x: 180, y:115)
                .font(.custom("Baskerville",size: 45))
                .padding()
                .background(Color(red: 32/255, green: 32/255, blue: 27/255))
                .foregroundColor(.white)
                .bold()
                
                Spacer()
            }
        }
    }
}
