//
//  ViewController.swift
//  WordShuffle
//
//  Created by Hai Nguyen on 2/1/21.
//

import UIKit

class ViewController: UITableViewController {
    var allWords: [String] = [String]()
    var usedWords: [String] = [String]()
    var usedWordsLowerCased: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWords()
        setUpGame()
        startGame()
        
    }
    
    func loadWords() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords.append("silkworm")
        }
    }
    
    func setUpGame() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
    }
    
    func startGame() {
        self.title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc
    func restartGame() {
        startGame()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submitAnswer(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submitAnswer(_ answer: String) {
        if (!isValid(answer: answer)) {
            showInvalidAnswerAlert(answer)
            return
        }
        
        usedWords.insert(answer, at: 0)
        usedWordsLowerCased.insert(answer.lowercased(), at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func showInvalidAnswerAlert(_ answer: String) {
        let alertTitle: String
        let alertMessage: String
        if !isPossible(answer) {
            guard let title = title else { return }
            alertTitle = "Word is not possible"
            alertMessage = "This word cannot be made from the letters in \(title.lowercased())"
        } else if !isReal(answer) {
            alertTitle = "Word does not exist"
            alertMessage = "Don't go making up words buddy."
        } else if !isOrginal(answer) {
            alertTitle = "Word is not unique"
            alertMessage = "You've already tried this, think of a different word."
        } else if !isAnswerLongEnough(answer) {
            alertTitle = "Word is too short"
            alertMessage = "Think of a word that has more than 2 letters."
        } else {
            alertTitle = "Word is given"
            alertMessage = "Think of words that are different than the one already given."
        }
        
        let vc = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .default))
        present(vc, animated: true)
    }
    
    func isValid(answer: String) -> Bool {
        return isPossible(answer) && isOrginal(answer) && isReal(answer) && isAnswerLongEnough(answer) && !isStartWord(answer)
    }
    
    func isAnswerLongEnough(_ word: String) -> Bool {
        return word.count > 2
    }
    
    func isStartWord(_ word: String) -> Bool {
        guard let title = title else { return false }
        return title.lowercased() == word.lowercased()
    }
    
    func isPossible(_ answer: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        for letter in answer.lowercased() {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOrginal(_ answer: String) -> Bool {
        return !usedWordsLowerCased.contains(answer.lowercased())
    }
    
    func isReal(_ answer: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: answer.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: answer, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }

}

