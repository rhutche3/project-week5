import SwiftUI

struct Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
}

struct ContentView: View {
    @State private var questions = [
        Question(text: "What is the capital of North Carolina?", answers: ["Charlotte", "Raleigh", "Winston-Salem", "High Point"], correctAnswerIndex: 1),
        Question(text: "What school are you currently in?", answers: ["University of North Carolina at Charlotte", "University of North Carolina at Greensboro", "University of North Carolina at Chapel Hill", "University of North Carolina at Asheville"], correctAnswerIndex: 0),
        Question(text: "What color is the sky?", answers: ["Red", "Yellow", "Green", "Blue"], correctAnswerIndex: 3)
    ]

    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var showScore = false

    var body: some View {
        VStack {
            Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                .font(.headline)
                .padding()

            Text(questions[currentQuestionIndex].text)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()

            ForEach(0..<questions[currentQuestionIndex].answers.count, id: \.self) { index in
                Button(action: {
                    answerTapped(index)
                }) {
                    Text(questions[currentQuestionIndex].answers[index])
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
        .alert(isPresented: $showScore) {
            Alert(
                title: Text("Game Over!"),
                message: Text("Your score is: \(score) out of \(questions.count)"),
                dismissButton: .default(Text("Restart")) {
                    restartGame()
                }
            )
        }
    }

    func answerTapped(_ index: Int) {
        if index == questions[currentQuestionIndex].correctAnswerIndex {
            score += 1
        }
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        } else {
            showScore = true
        }
    }

    func restartGame() {
        score = 0
        currentQuestionIndex = 0
        showScore = false
    }
}
