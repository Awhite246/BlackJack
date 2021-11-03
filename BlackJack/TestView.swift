//
//  TestView.swift
//  BlackJack
//
//  Created by Student on 10/25/21.
//

import SwiftUI

struct TestView: View {
    @State private var numPlayers = 1.0
    @State private var cardBack = 8
    @State private var screen = "home"
    @State private var charNum = 0
    @State private var userName = ""
    @State private var logoAnimate = false
    @State private var cardAnimate = false
    @State private var charPics = ["","","",""]
    @State private var userNames = ["","","",""]
    @State private var cardDeck = ["DiamondA","Diamond2","Diamond3","Diamond4","Diamond5","Diamond6","Diamond7","Diamond8","Diamond9","Diamond10","DiamondJ","DiamondQ","DiamondK","ClubA","Club2","Club3","Club4","Club5","Club6","Club7","Club8","Club9","Club10","ClubJ","ClubQ","ClubK","HeartA","Heart2","Heart3","Heart4","Heart5","Heart6","Heart7","Heart8","Heart9","Heart10","HeartJ","HeartQ","HeartK","SpadeA","Spade2","Spade3","Spade4","Spade5","Spade6","Spade7","Spade8","Spade9","Spade10","SpadeJ","SpadeQ","SpadeK"]
    @State private var count = 0
    @State private var currentPlayer = 0
    @State private var player1 = [String]()
    @State private var player2 = [String]()
    @State private var player3 = [String]()
    @State private var player4 = [String]()
    var body : some View {
        ZStack {
            VStack {
                Image("Background1")
                    .frame(width: 400, height: 550, alignment: .top)
                    .colorMultiply(.blue)
                Image("Background2")
                    .resizable()
                    .frame(width: 400, height: 290, alignment: .top)
                    .border(Color.gray, width: 3)
            }
            VStack {
                HStack {
                    ForEach(0..<8){
                        Image(cardDeck[$0])
                            .resizable()
                            .frame(width: 40, height: 60, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .border(count == $0 ? Color.red : Color.clear, width: 2)
                        
                    }
                }
                .padding(.top, 300)
                Text("\(count)")
                Text("\(currentPlayer)")
                HStack {
                    ForEach(player1.indices, id: \.self) { index in
                        Text("\(player1[index])")
                    }
                }
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(player1.indices, id: \.self) { index in
                            Image(player1[index])
                                .resizable()
                                .frame(width: 100, height: 150, alignment: .center)
                                .aspectRatio(contentMode: .fit)
                        }
                        
                    }
                }
                .frame(width: 350, height: 150, alignment: .center)
                HStack {
                    Button {
                        addPlayerCard(current: currentPlayer, text: cardDeck[count])
                        count += 1
                        count %= 52
                        currentPlayer += 1
                        currentPlayer %= 4
                    } label: {
                        Text ("Hit")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .disabled(checkPlayer(current: currentPlayer))
                    Button {
                        addPlayerCard(current: currentPlayer, text: "Stand")
                        currentPlayer += 1
                        currentPlayer %= 4
                    } label: {
                        Text ("Stand")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .padding(.bottom)
            }
            .onAppear(perform: {
                cardDeck = cardDeck.shuffled()
            })
            .preferredColorScheme(.dark)
        }
    }
    func addPlayerCard (current : Int, text : Any) {
        switch current {
        case 0:
            player1.append("\(text)")
        case 1:
            player2.append("\(text)")
        case 2:
            player3.append("\(text)")
        case 3:
            player4.append("\(text)")
        default:
            break
        }
    }
    func checkPlayer (current : Int) -> Bool {
        switch current {
        case 0:
            if player1.last == "Stand" {
                return true
            }
        case 1:
            if player2.last == "Stand" {
                return true
            }
        case 2:
            if player3.last == "Stand" {
                return true
            }
        case 3:
            if player4.last == "Stand" {
                return true
            }
        default:
            break
        }
        return false
    }
}
struct Background: View {
    var body : some View {
        Image("BackGround")
    }
}
struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
