//
//  ContentView.swift
//  BlackJack
//
//  Created by Student on 10/25/21.
//

import SwiftUI

struct ContentView: View {
    @State private var numPlayers = 1.0
    @State private var screen = "home"
    @State private var logoAnimate = false
    @State private var charPics = [String]()
    @State private var userNames = [String]()
    var body: some View {
        VStack {
            if screen == "home" {
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
            } else if screen == "game"{
                Group {
                    Spacer()
                }
            }else if screen == "username"{
                Group {
                    Text("User Select")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }else{
                Group {
                    Spacer()
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
