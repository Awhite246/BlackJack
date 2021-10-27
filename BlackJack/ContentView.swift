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
    @State private var userName = ""
    @State private var logoAnimate = false
    @State private var cardAnimate = false
    @State private var charPics = ["","","",""]
    @State private var userNames = ["","","",""]
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
                    .disabled((userNames[0] == "") || (userNames[1] == "" && numPlayers > 1) || (userNames[2] == "" && numPlayers > 2) || (userNames[3]) == "" && numPlayers > 3)
                    Button ("Character Select") {
                        screen = "username"
                    }
                    .font(.title2)
                    .padding(25)
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
                    Text("Character Select")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(120), spacing: 0),count: 3), spacing: 19, content: {
                        ForEach(0..<12){ index in
                            Image("User\(1 + index)")
                                .resizable()
                                .frame(width: 45, height: 70, alignment: .center)
                                .aspectRatio(contentMode: .fit)
                                .border(Color.gray, width: 1)
                                .grayscale(charPics.contains("User\(1+index)") ? 0.9 : 0)
                                .blur(radius: charPics.contains("User\(1+index)") ? 2 : 0)
                                .onTapGesture {
                                    if (!charPics.contains("User\(1+index)")){
                                        charPics[charNum] = "User\(index + 1)"
                                    }
                                }
                        }
                    })
                    Text("Selected Character")
                        .padding(.top, 20)
                    Image(charPics[charNum] != "" ? charPics[charNum] : "User5")
                        .resizable()
                        .frame(width: 45, height: 70, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .border(Color.white, width: 1)
                        .grayscale(charPics[charNum] != "" ? 0 : 0.9)
                        .blur(radius: charPics[charNum] != "" ? 0 : 2)
                    TextField("Username", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .frame(width: 200, height: 30, alignment: .center)
                        .font(.body)
                        .padding()
                    Spacer()
                    Button("Done") {
                        userNames[charNum] = userName
                        screen = "username"
                    }
                    .disabled(charPics[charNum] == "" || userName == "")
                    .padding()
                }
            case "game":
                Group {
                    Text("test")
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
