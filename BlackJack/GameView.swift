//
//  GameView.swift
//  BlackJack
//
//  Created by Student on 11/9/21.
//

import SwiftUI

struct GameView: View {
    let numPlayers : Int
    let cardBack : Int
    let deckCount : Int
    let charPics : Array<String>
    let userNames : Array<String>
    @State private var mixedDeck = [String]()
    @State private var count = 0
    @State private var currentPlayer = 0
    @State private var player1 = Player()
    @State private var player2 = Player()
    @State private var player3 = Player()
    @State private var player4 = Player()
    @State private var nextTurn = false
    @State private var endGame = false
    @State private var finishedCount = 0
    var body: some View {
        let cardDeck = ["DiamondA","Diamond2","Diamond3","Diamond4","Diamond5","Diamond6","Diamond7","Diamond8","Diamond9","Diamond10","DiamondJ","DiamondQ","DiamondK","ClubA","Club2","Club3","Club4","Club5","Club6","Club7","Club8","Club9","Club10","ClubJ","ClubQ","ClubK","HeartA","Heart2","Heart3","Heart4","Heart5","Heart6","Heart7","Heart8","Heart9","Heart10","HeartJ","HeartQ","HeartK","SpadeA","Spade2","Spade3","Spade4","Spade5","Spade6","Spade7","Spade8","Spade9","Spade10","SpadeJ","SpadeQ","SpadeK"]
        var offCount = 0
        ZStack {
            VStack {
                Image("Background1")
                    .frame(width: 400, height: 605, alignment: .top)
                    .colorMultiply(.blue)
                Image("Background2")
                    .resizable()
                    .frame(width: 400, height: 250, alignment: .top)
                    .border(Color.gray, width: 3)
            }
            VStack {
                Text("")
                    .padding(.top, 28)
                ForEach(0..<Int(numPlayers)) { i in
                    HStack (alignment: .bottom){
                        Image("\(charPics[i])")
                            .resizable()
                            .frame(width: 40, height: 60, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                        Text("\(userNames[i]):")
                            .font(.title3)
                            .fontWeight(.heavy)
                    }
                    HStack {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack {
                                switch (i) {
                                case 0:
                                    showPlayerCard(player: player1, imageW: 40, imageH: 60)
                                case 1:
                                    showPlayerCard(player: player2, imageW: 40, imageH: 60)
                                case 2:
                                    showPlayerCard(player: player3, imageW: 40, imageH: 60)
                                case 3:
                                    showPlayerCard(player: player4, imageW: 40, imageH: 60)
                                default:
                                    Text("")
                                }
                            }
                        }
                        .frame(width: 170, height: 40, alignment: .center)
                    }
                }
                Text("\(player1.calcHand(hand: 1))")
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        switch (currentPlayer) {
                        case 0:
                            showPlayerCard(player: player1, imageW: 100, imageH: 140)
                        case 1:
                            showPlayerCard(player: player2, imageW: 100, imageH: 140)
                        case 2:
                            showPlayerCard(player: player3, imageW: 100, imageH: 140)
                        case 3:
                            showPlayerCard(player: player4, imageW: 100, imageH: 140)
                        default:
                            Text("")
                        }
                    }
                }
                .frame(width: 350, height: 150, alignment: .center)
                HStack {
                    Button {
                        addPlayerCard(current: currentPlayer, text: cardDeck[count])
                        count += 1
                        count %= 52 * deckCount
                        for i in 0...Int(numPlayers) - 1 {
                            if checkPlayer(current: (currentPlayer + 1 + i) % Int(numPlayers)){
                                
                            } else {
                                if (currentPlayer + 1 + i) % Int(numPlayers) == currentPlayer {
                                    break
                                }
                                offCount = i
                                nextTurn = true
                                break
                            }
                        }
                        
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
                        for i in 0...Int(numPlayers) - 1 {
                            if checkPlayer(current: (currentPlayer + 1 + i) % Int(numPlayers)){
                                
                            } else {
                                if (currentPlayer + 1 + i) % Int(numPlayers) == currentPlayer {
                                    break
                                }
                                offCount = i
                                nextTurn = true
                                break
                            }
                        }
                        finishedCount += 1
                        if (finishedCount == Int(numPlayers)) {
                            endGame = true
                        }
                    } label: {
                        Text ("Stand")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .disabled(isFirst(current: currentPlayer))
                }
                .padding(.bottom)
            }
            .onAppear(perform: {
                for _ in 0..<deckCount {
                    mixedDeck.append(contentsOf: cardDeck)
                }
                mixedDeck.shuffle()
            })
            .preferredColorScheme(.dark)
            //transparent next player thingy
            Color.black
                .opacity(nextTurn || endGame ? 0.85 : 0)
            VStack {
                Text(nextTurn ? "\(userNames[(currentPlayer + 1 + offCount) % Int(numPlayers)]) is up" : "")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                Image(nextTurn ? "\(charPics[(currentPlayer + 1 + offCount) % Int(numPlayers)])" : "")
                    .resizable()
                    .frame(width: 100, height: 150, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                Button {
                    nextTurn = false
                    currentPlayer += 1 + offCount
                    currentPlayer %= Int(numPlayers)
                } label : {
                    Text(nextTurn ? "Ok" : "")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                }
            }
            VStack {
                Text(endGame ? "Game is over" : "")
            }
        }
    }
    func addPlayerCard (current : Int, text : String) {
        switch current {
        case 0:
            player1.addToHand(text: text, hand: 1)
        case 1:
            player2.addToHand(text: text, hand: 1)
        case 2:
            player3.addToHand(text: text, hand: 1)
        case 3:
            player4.addToHand(text: text, hand: 1)
        default:
            break
        }
    }
    func checkPlayer (current : Int) -> Bool {
        switch current {
        case 0:
            if player1.getHand(hand: 1).contains("Stand") {
                return true
            }
        case 1:
            if player2.getHand(hand: 1).contains("Stand") {
                return true
            }
        case 2:
            if player3.getHand(hand: 1).contains("Stand") {
                return true
            }
        case 3:
            if player4.getHand(hand: 1).contains("Stand") {
                return true
            }
        default:
            return false
        }
        return false
    }
    func isFirst (current : Int) -> Bool {
        switch current {
        case 0:
            if player1.getHand(hand: 1).isEmpty {
                return true
            }
        case 1:
            if player2.getHand(hand: 1).isEmpty {
                return true
            }
        case 2:
            if player3.getHand(hand: 1).isEmpty {
                return true
            }
        case 3:
            if player4.getHand(hand: 1).isEmpty {
                return true
            }
        default:
            return false
        }
        return false
    }
    
}
struct showPlayerCard: View {
    let player : Player
    let imageW : CGFloat
    let imageH : CGFloat
    var body: some View{
        ForEach(player.getHand(hand: 1).indices, id: \.self) { index in
            Image(player.getHand(index: index, hand: 1))
                .resizable()
                .frame(width: imageW, height: imageH, alignment: .center)
                .aspectRatio(contentMode: .fit)
        }
        Image(player.getHand(hand: 1).isEmpty ? " " : "")
            .resizable()
            .frame(width: imageW, height: imageH, alignment: .center)
            .aspectRatio(contentMode: .fit)
    }
}
struct Player {
    private var hand1 = [String]()
    private var hand2 = [String]()
    private var split = false
    private var over = false
    
    mutating func addToHand (text : String, hand : Int) {
        if text == "Stand" {
            over = true
        } else {
            switch hand {
            case 1:
                hand1.append("\(text)")
            case 2:
                hand2.append("\(text)")
            default:
                break
            }
            
        }
    }
    mutating func splitHand (){
        split = true
    }
    func calcHand(hand : Int) -> Int {
        var total = 0
        switch (hand) {
        case 1:
            for card in hand1 {
                if card.contains("K") || card.contains("Q") || card.contains("J") {
                    total += 10
                } else if !card.contains("A") {
                    if card.last != "0" {
                        if let num = card.last?.wholeNumberValue {
                            total += num
                        }
                    } else if card.last == "0"{
                        total += 10
                    }
                } else {
                    if total + 11 > 21 {
                        total += 1
                    } else {
                        total += 11
                    }
                }
            }
        case 2:
            for card in hand2 {
                if card.contains("K") || card.contains("Q") || card.contains("J") {
                    total += 10
                } else if !card.contains("A") {
                    if card.last != "0" {
                        if let num = card.last?.wholeNumberValue {
                            total += num
                        }
                    } else if card.last == "0"{
                        total += 10
                    }
                } else {
                    if total + 11 > 21 {
                        total += 1
                    } else {
                        total += 11
                    }
                }
            }
        default:
            total += 0
        }
        return total
    }
    func getHand(index : Int, hand : Int) -> String {
        switch hand {
        case 1:
            return hand1[index]
        case 2:
            return hand2[index]
        default:
            return hand1[index]
        }
    }
    func getHand(hand : Int) -> Array<String> {
        switch hand {
        case 1:
            return hand1
        case 2:
            return hand2
        default:
            return hand1
        }
    }
    func isSplit () -> Bool {
        return split
    }
    func isOver () -> Bool {
        return over
    }
    func isFirst () -> Bool {
        
        return false
    }
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(numPlayers: 1, cardBack: 8, deckCount : 2, charPics: ["User1","","",""], userNames: ["Guy1","","",""])
    }
}
