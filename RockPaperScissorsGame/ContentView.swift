//
//  ContentView.swift
//  RockPaperScissorsGame
//
//  Created by 강민혜 on 10/1/23.
//

import SwiftUI

enum RPSComponent: String {
    case rock
    case paper
    case scissors
    
    var winMatch: String {
        switch self {
        case .rock: return "paper"
        case .paper: return "scissors"
        case .scissors: return "rock"
        }
    }
    
    var loseMatch: String {
        switch self {
        case .rock: return "scissors"
        case .paper: return "rock"
        case .scissors: return "paper"
        }
    }
    
}

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var showingResetAlert = false
    @State private var scoreTitle = ""
    
    @State var rpsArray = [RPSComponent.rock, RPSComponent.paper, RPSComponent.scissors].shuffled()
    
    @State private var computerSelectRPS = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random() // 이겨야 할지, 져야할지 가이드
    
    @State private var selectedRPS = RPSComponent.rock // 사용자가 선택한 값
    @State private var scoreValue = 0
    @State private var roundCount = 0
    
    var body: some View {
        
        ZStack {
            
            RadialGradient(stops: [
                .init(color: .yellow, location: 0.3),
                .init(color: .blue, location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                // 문제 제시
                VStack(spacing: 20) {
                    Text("Score : \(scoreValue)")
                        .scoreStyle()
                        .foregroundColor(scoreValue < 0 ? .red : .green)
                    Text("you should")
                }
                
                Spacer()
                
                VStack {
                    Text(shouldWin ? "WIN" : "LOSE")
                        .prominentResultStyle()
                }
                
                // 컴퓨터의 선택 제시
                VStack {
                    HandImage(imageName: rpsArray[computerSelectRPS].rawValue)
                }
                
                // 사용자의 선택
                HStack(alignment: .center, spacing: 10) {
                    ForEach(0..<3) { number in
                        Button {
                            // 가위바위보중 하나 클릭
                            rpsTapped(number)
                        } label: {
                            HandImage(imageName: rpsArray[number].rawValue)
                        }
                    }
                }
                
                Spacer()
                
                Text("round : \(roundCount) / 10")
                    .scoreStyle()
                    .foregroundColor(.yellow)

                Spacer()
                Spacer()
                
            }

        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreValue)")
        }
        .alert("⭐️Finished!⭐️", isPresented: $showingResetAlert) {
            Button("Restart", action: reset)
        } message: {
            Text("Your total score is \(scoreValue)! \n Great job!🙌")
        }
        
    }
    
    func rpsTapped(_ number: Int) {
        
        let correctAnswer = shouldWin ? rpsArray[computerSelectRPS].winMatch : rpsArray[computerSelectRPS].loseMatch
        
        let isCorrect = correctAnswer == rpsArray[number].rawValue
        
        if isCorrect {
            scoreTitle = "Correct 😎"
            scoreValue += 10
        } else {
            scoreTitle = "Wrong! 😢 \n You should select \(correctAnswer)"
            scoreValue -= 10
        }
        
        roundCount += 1
        showingScore = roundCount < 10
        showingResetAlert = roundCount == 10

    }
    
    func askQuestion() {
        rpsArray.shuffle()
        shouldWin.toggle()
    }
    
    func reset() {
        askQuestion()
        scoreValue = 0
        roundCount = 0
    }
}

struct HandImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable(resizingMode: .stretch)
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 24.0))
            .shadow(radius: 5)

    }
}

struct ProminentResult: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.yellow)
    }
}


struct ScoreStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
    }
}

extension View {
    func prominentResultStyle() -> some View {
        modifier(ProminentResult())
    }
    
    func scoreStyle() -> some View {
        modifier(ScoreStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
