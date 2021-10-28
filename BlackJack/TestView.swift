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
    @State private var cardDeckRandom = ["DiamondA","Diamond2","Diamond3","Diamond4","Diamond5","Diamond6","Diamond7","Diamond8","Diamond9","Diamond10","DiamondJ","DiamondQ","DiamondK","ClubA","Club2","Club3","Club4","Club5","Club6","Club7","Club8","Club9","Club10","ClubJ","ClubQ","ClubK","HeartA","Heart2","Heart3","Heart4","Heart5","Heart6","Heart7","Heart8","Heart9","Heart10","HeartJ","HeartQ","HeartK","SpadeA","Spade2","Spade3","Spade4","Spade5","Spade6","Spade7","Spade8","Spade9","Spade10","SpadeJ","SpadeQ","SpadeK"]
    @State private var switchy = false
    var body : some View {
        VStack {
            ForEach (0..<5) { i in
                HStack {
                    Text("Card \(cardDeckRandom[i])\t")
                        .font(.title)
                        .padding()
                        .frame(alignment: .leading)
                    Image("\(cardDeckRandom[i])")
                        .resizable()
                        .frame(width: 75, height: 110, alignment: .trailing)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
            }
            .frame(width: 500, height: 110, alignment: .center)
            Button ("Randomize") {
                cardDeckRandom = cardDeck.shuffled()
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
