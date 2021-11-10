//
//  TestView.swift
//  BlackJack
//
//  Created by Student on 10/25/21.
//

import SwiftUI

struct TestView: View {
    @State private var numPlayers = 4.0
    @State private var cardBack = 8
    @State private var screen = "home"
    @State private var charNum = 0
    @State private var userName = ""
    @State private var logoAnimate = false
    @State private var cardAnimate = false
    @State private var charPics = ["User2","User5","User9","User3"]
    @State private var userNames = ["Bob","Joe","Steve","Greg"]
    @State private var cardRotation = 0
    var body : some View {
        VStack {
            Text("Character Select")
                .font(.title)
                .fontWeight(.bold)
            Form {
                ForEach (0..<4) { i in
                    HStack {
                        if Int(numPlayers) > i {
                            Button (userNames[i] == "" ? "Player \(i + 1)" : "\(userNames[i])") {
                                screen = "character"
                                charNum = i
                                userName = userNames[charNum]
                            }
                            .padding()
                        } else {
                            if (userNames[i] == ""){
                                Text("Empty")
                                    .foregroundColor(.gray)
                                    .padding()
                            } else {
                                Text(userNames[i])
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                        Spacer()
                        Image (charPics[i] == "" ? "User5" : "\(charPics[i])")
                            .resizable()
                            .frame(width: 40, height: 50, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .grayscale((charPics[i] != "") && (Int(numPlayers) > i) ? 0 : 0.99)
                            .blur(radius: (charPics[i] != "") && (Int(numPlayers) > i) ? 0 : 1)
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
                    //.rotationEffect(.init(degrees: cardAnimate ? -3 : 1))
//                    .rotation3DEffect(
//                        .degrees(cardRotation),
//                        axis: (x: 1, y: 1, z: 0)
//                    )
//                    .animation(
//                        Animation.linear(duration: 0.1)
//                            .delay(0.05)
//                    )
                    .onTapGesture{
                        cardBack %= 8
                        cardBack += 1
                        if cardAnimate {
                            cardAnimate = false
                        } else {
                            cardAnimate = true
                        }
                        withAnimation(.interpolatingSpring(stiffness: 10, damping: 6)) {
                            cardRotation += 360
                        }
                    }
                Text("Click to change the back of your cards")
            }
            .frame(width: 390, alignment: .center)
            Button("Back"){
                screen = "home"
            }
            .padding()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
