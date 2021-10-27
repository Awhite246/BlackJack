//
//  ContentView.swift
//  BlackJack
//
//  Created by Student on 10/25/21.
//

import SwiftUI

struct ContentView: View {
    @State private var numPlayers = 1.0
    @State private var cardBack = 8
    @State private var screen = "home"
    @State private var charNum = 0
    @State private var logoAnimate = false
    @State private var cardAnimate = false
    @State private var charPics = [String]()
    @State private var userNames = [String]()
    var body: some View {
        VStack {
            switch (screen) {
            case "home":
                Group {
                    Text("Black Jack")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Image("Logo")
                        .resizable()
                        .frame(width: 300, height: 200, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .rotationEffect(.init(degrees: logoAnimate ? -8 : 8))
                        .animation(Animation.linear(duration: 5).delay(0.25).repeatForever())
                        .onAppear(perform: {
                            logoAnimate = true;
                        })
                    Slider(value: $numPlayers, in: 1...4, step: 1.0)
                        .padding()
                    Text("Player Count: \(numPlayers, specifier: "%.f")")
                    Button ("Play Game") {
                        screen = "game"
                    }
                    .font(.title2)
                    .padding(.top, 70)
                    .disabled(userNames.count < Int(numPlayers))
                    Button ("Character Select") {
                        screen = "username"
                    }
                    .font(.title2)
                    .padding(25)
                }
            case "game":
                Group {
                    Text("test")
                }
            case "username":
                Group {
                    Text("Character Select")
                        .font(.title)
                        .fontWeight(.bold)
                    Form {
                        ForEach (0..<4) { i in
                            HStack {
                                if Int(numPlayers) > i {
                                    Button (userNames.count < i + 1 ? "Player \(i + 1)" : "\(userNames[i])") {
                                        screen = "character"
                                        charNum = i
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
                            )
                            .onTapGesture{
                                cardBack %= 8
                                cardBack += 1
                                if cardAnimate {
                                    cardAnimate = false
                                } else {
                                    cardAnimate = true
                                }
                            }
                        Text("Click to change the back of your cards")
                    }
                    Button("Back"){
                        screen = "home"
                    }
                    .padding()
                }
            case "character" :
                Group {
                    Text("")
                }
            default:
                Group {
                    Text("test")
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
