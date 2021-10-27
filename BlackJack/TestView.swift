//
//  TestView.swift
//  BlackJack
//
//  Created by Student on 10/25/21.
//

import SwiftUI

struct TestView: View {
    @State private var charPics = [String]()
    @State private var userNames = [String]()
    @State private var cardAnimate = false;
    @State private var charCount = 1.0
    @State private var numPlayers = 1.0
    @State private var screen = "username"
    @State private var cardBack = 8
    var body : some View {
        VStack {
            Text("Character Select")
                .font(.title)
                .fontWeight(.bold)
            Form {
                ForEach (0..<4) { i in
                    HStack {
                        if Int(numPlayers) > i {
                            Button (userNames.count < i + 1 ? "Player \(i + 1)" : "\(userNames[i])") {
                                screen = "character\(i)"
                            }
                            .padding()
                            Spacer()
                            Image (charPics.count < i + 1 ? "User5" : "\(charPics[i])")
                                .resizable()
                                .frame(width: 40, height: 50, alignment: .center)
                                .aspectRatio(contentMode: .fit)
                                .grayscale(charPics.count < i + 1 ? 0.99 : 0)
                                .blur(radius: charPics.count < i + 1 ? 1 : 0)
                        } else {
                            Text("Empty")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                }
            }
            .frame(width: 400, height: 300)
            .padding()
            HStack {
                Image("Back\(cardBack)")
                    .resizable()
                    .frame(width: 200, height: 300, alignment: .leading)
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(.init(degrees: cardAnimate ? -3 : 1))
                    .animation(
                        Animation.linear(duration: 0.1)
                            .delay(0.05)
                            .repeatCount(2, autoreverses: true)
                    )
                    .onTapGesture{
                        cardBack = 8 % (cardBack + 1)
                        
                    }
                Text("Click to change the back of your cards")
                    
            }
            Button("Back"){
                
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}
struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
