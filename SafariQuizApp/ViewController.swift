//
//  ViewController.swift
//  SafariQuizApp
//
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var questionImageView: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var answer1Button: UIButton!
    
    @IBOutlet weak var answer2Button: UIButton!
    
    @IBOutlet weak var answer3Button: UIButton!
    
    var questionIndex: Int = 0
    
    var score: Int = 0
    
    let questions: [QuestionModel] = [
        QuestionModel(image: UIImage(named: "lion")!, correctAnswer: 1, answer1: "Lion", answer2: "Elephant", answer3: "Ant"),
        QuestionModel(image: UIImage(named: "buffalo")!, correctAnswer: 3, answer1: "Monkey", answer2: "Dog", answer3: "Buffalo"),
        QuestionModel(image: UIImage(named: "giraffe")!, correctAnswer: 2, answer1: "Crocodile", answer2: "Giraffe", answer3: "Hippo"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        mountQuestion()
        
    }

    @IBAction func AnswerButtonTapped(_ sender: UIButton) {
        validateAnswer(answer: sender.tag)
    }
    
    func validateAnswer(answer: Int) {
        
        let correctAnswer = questions[questionIndex].correctAnswer
        
        if correctAnswer == answer {
            score += 1
            scoreLabel.text = "Score: \(score)"
        }
        
        displayResultAlert(answerIsCorrect: correctAnswer == answer)
        
    }
    
    func displayResultAlert(answerIsCorrect: Bool) {
        let title = answerIsCorrect ? "Correct" : "Incorrect"
        let message = answerIsCorrect ? "You got it!" : "Not quite!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in self.moveToNextQuestion() })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func moveToNextQuestion() {
        questionIndex += 1

        if questionIndex >= questions.count {
            
            let alert = UIAlertController(title: "Quiz completed", message: "Your score was \(score) out of \(questions.count)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.questionIndex = 0
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.mountQuestion()

            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            mountQuestion()
        }
    }
    
    func mountQuestion() {
        questionImageView.image = questions[questionIndex].image
        answer1Button.setTitle(questions[questionIndex].answer1, for: .normal)
        answer2Button.setTitle(questions[questionIndex].answer2, for: .normal)
        answer3Button.setTitle(questions[questionIndex].answer3, for: .normal)
    }
    
}

