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
    @State private var charPics = [String]()
    @State private var userNames = [String]()
    var body : some View {
        VStack {
            Text("Character Select")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(120), spacing: 0),count: 3), spacing: 19, content: {
                var offCount = 0
                ForEach(0..<12 - charPics.count){ index in
                    if (charPics.contains("User\(index + 1 + offCount)")){
                        offCount += 1
                    }
                    Image("User\(index + 1 + offCount)")
                        .resizable()
                        .frame(width: 45, height: 70, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .border(Color.gray, width: 1)
                        .onTapGesture {
                            if charPics.count <= charNum {
                                charPics.insert("User\(index + 1)", at: index)
                            } else {
                                charPics[charNum] = "User\(index + 1)"
                            }
                        }
                }
            })
            Text("Selected Character")
                .padding(.top, 20)
            Image(charPics.count > charNum ? charPics[charNum] : "User5")
                .resizable()
                .frame(width: 45, height: 70, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .border(Color.white, width: 1)
                .grayscale(charPics.count > charNum ? 0 : 0.9)
                .blur(radius: charPics.count > charNum ? 0 : 2)
            TextField("Username", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
                .frame(width: 200, height: 30, alignment: .center)
                .font(.body)
                .padding()
            Spacer()
            Button("Done") {
                
            }
            .disabled(charPics.count >= charNum || userName == "")
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
