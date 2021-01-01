//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Hai Nguyen on 31/12/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    let QUESTIONS_PER_GAME = 3
    
    var countries = [String]()
    var score: Int = 0
    var correctAnswer = 0
    var numberQuestionsAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        setUpFlagUI()
        askQuestion()
    }
    
    func setUpFlagUI() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray
            .cgColor
        button2.layer.borderColor = UIColor.lightGray
            .cgColor
        button3.layer.borderColor = UIColor.lightGray
            .cgColor
        
        // To set custom color
        // button1.layer.boderColor = UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
    }
    
    func askQuestion(action: UIAlertAction? = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        // second param .normal means that standard state of the button
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = "\(countries[correctAnswer].uppercased()) - \(score)"
    }
    
    /*
     Connected to all 3 buttons
     */
    @IBAction func buttonTapped(_ sender: UIButton) {
        numberQuestionsAnswered = (numberQuestionsAnswered + 1) % QUESTIONS_PER_GAME
        
        // sender specifies which button
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong, you picked \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        // Some reason this isn't allowed
        let handler: (UIAlertAction) -> Void = numberQuestionsAnswered == 0 ? showFinalScreen : askQuestion
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: handler))
        present(ac, animated: true)
        
    }
    
    func showFinalScreen(action: UIAlertAction? = nil) {
        let ac = UIAlertController(title: "Good game", message: "Your final score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: resetGame))
        present(ac, animated: true)
    }
    
    func resetGame(action: UIAlertAction? = nil) {
        score = 0
        numberQuestionsAnswered = 0
        askQuestion()
    }
    
}

