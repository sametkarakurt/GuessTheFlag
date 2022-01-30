//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Samet Karakurt on 30.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var gameNotStart = true
    @State private var scaleAmount = 1.0
    @State private var animationAmount = 0.0
    @State private var tappedFlag : Int = -1
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
 
    
    @State private var score = 0

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.45),Color(red: 0.76, green: 0.15, blue: 0.26)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                      
             
                        Button {
                            flagTapped(number)
                            scaleAmount -= 0.10
                            
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        .opacity(gameNotStart || tappedFlag == number ?  1 : 0.25  )
                        .rotation3DEffect(.degrees(animationAmount), axis: (tappedFlag == number ? (x: 0, y: 1, z: 0) : (x: 0, y: 0, z: 0)))
                        .scaleEffect(tappedFlag != number ? scaleAmount : 1)
                        .animation(.default, value: scaleAmount)
                    }
                }
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text("Your score is \(score)")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
          

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }

    }
    

    

    func flagTapped(_ number: Int) {
   
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }
        withAnimation{
            animationAmount += 360
        }
        tappedFlag = number
        showingScore = true
        gameNotStart = false
    }

    func askQuestion() {
        scaleAmount = 1
        tappedFlag = -1
        gameNotStart = true
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
