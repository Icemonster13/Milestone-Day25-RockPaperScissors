//
//  ContentView.swift
//  25-RockPaperScissors
//
//  Created by Michael & Diana Pascucci on 4/26/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - CONSTANTS
    let choices: [String] = ["🪨", "📄", "✂️", "🦎", "🖖🏽", "🪨", "📄", "✂️", "🦎", "🖖🏽"]
    let winMoves: [String] = ["📄", "✂️", "🖖🏽", "🪨", "🦎", "🖖🏽", "🦎", "🪨", "✂️", "📄"]
    let loseMoves: [String] = ["🦎", "🪨", "📄", "🖖🏽", "✂️", "✂️", "🖖🏽", "🦎", "📄", "🪨"]
    let gameLength: Int = 10
    
    // MARK: - @STATE PROPERTIES
    @State private var appChoice: Int = Int.random(in: 0...4)
    @State private var appShouldWin: Bool = Bool.random()
    @State private var userChoice: Int = 0
    @State private var attemptNumber: Int = 1
    @State private var score: Int = 0
    
    // MARK: - ALERT PROPERTIES
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var alertButton: String = ""
    
    // MARK: - COMPUTED PROPERTIES
    private var gameReset: Bool {
        attemptNumber > gameLength
    }
    
    private var correctAnswers: [String] {
        var myArray = [String]()
        if appShouldWin {
            myArray.append(winMoves[appChoice])
            myArray.append(winMoves[appChoice + 5])
        } else {
            myArray.append(loseMoves[appChoice])
            myArray.append(loseMoves[appChoice + 5])
        }
        return myArray
    }
    
    // MARK: - METHODS
    func setCriteria() {
        appShouldWin.toggle()
        appChoice = Int.random(in: 0...4)
    }
    
    func evaluateAnswer(choice: Int) {
        if correctAnswers.contains(choices[choice]) {
            score += 1
            alertTitle = "Right"
        } else {
            alertTitle = "Wrong"
        }
        attemptNumber += 1
        if gameReset {
            alertTitle = "Game Over"
            alertMessage = "You scored \(score) out of \(gameLength)"
            alertButton = "Reset"
            attemptNumber = 1
            score = 0
        } else {
            alertMessage = "You chose \(choices[userChoice])"
            alertButton = "Continue"
        }
        showingAlert = true
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                Text("Rock, Paper, Scissors,\nLizard, Spock")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 20) {
                    Divider()
                
                    Text("""
                        Scissors cuts Paper, Paper covers Rock,
                        Rock crushes Lizard, Lizard poisons Spock,
                        Spock smashes Scissors,
                        Scissors decapitate Lizard,
                        Lizard eats Paper, Paper disproves Spock,
                        Spock vaporizes Rock, and as it always has...
                        Rock crushes scissors!
                        """)
                    .font(.subheadline)
                        .multilineTextAlignment(.center)
                    
                    Divider()
                }
                
                Group {
                    HStack {
                        Text("The app chose:")
                        Text(choices[appChoice])
                    }
                    VStack(spacing: 0) {
                        HStack {
                            Text("If the player should")
                            Text(appShouldWin ? "WIN" : "LOSE")
                                .foregroundColor(appShouldWin ? Color.green : Color.red)
                                .fontWeight(.bold)
                            Text("...")
                        }
                        Text("Which is the right choice?")
                    }
                }
                .font(.title)
                
                HStack(spacing: 10) {
                    ForEach(0..<5) { number in
                        Button {
                            userChoice = number
                            evaluateAnswer(choice: number)
                        } label: {
                            Text(choices[number])
                                .font(.system(size: 40))
                                .padding(0)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.cyan)
                        .shadow(radius: 10)
                    }
                } //: Button HStack
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button(alertButton, action: setCriteria)
                } message: {
                    Text(alertMessage)
                }
                
                Group {
                    Spacer()
                    attemptNumber > 1 ? Text("Current Score: \(score) / \(attemptNumber - 1)") : Text("")
                    Spacer()
                }
                .font(.largeTitle)
            } //: Outer VStack
            .foregroundColor(.white)
        } //: ZStack
    } //: Body
} //: ContentView


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
