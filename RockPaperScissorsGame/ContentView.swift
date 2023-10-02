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
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
