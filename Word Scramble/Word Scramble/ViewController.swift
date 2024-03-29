//
//  ViewController.swift
//  Word Scramble
//
//  Created by Hussein Nagri on 2019-09-18.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New game", style: .plain, target: self, action: #selector(startGame))
        
        
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try?String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    @objc func startGame (){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
            
        }
        ac.addAction(submitAction)
        present(ac,animated: true)
    }

    func submit (_ answer: String){
        let lowerAnswer = answer.lowercased()
        
        let errorTitle : String
        let errorMessage : String
        
        
        if (isPossible(word: lowerAnswer)){
            if (isOriginal(word: lowerAnswer)){
                if (isReal(word: lowerAnswer)){
                    if(lowerAnswer.count > 3 || lowerAnswer != title){
                        usedWords.insert(answer, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        return
                    }else{
                        
                        
                        errorTitle = "Word is either too short or same as title"
                        errorMessage = "You need a word longer than 3 characters, or an original word"
                        showErrorMessage(errorMessage, withTitle: errorTitle)
                    }
                    
                    
                }else{
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up!"
                    showErrorMessage(errorMessage, withTitle: errorTitle)
                }
            }else{
                errorTitle = "Word already used "
                errorMessage = "Be more original!"
                showErrorMessage(errorMessage, withTitle: errorTitle)
            }
        }else{
            guard let title = title else {return}
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title.lowercased()) !"
            showErrorMessage(errorMessage, withTitle: errorTitle)
        }
        
        
    }
    func isPossible(word: String) -> Bool{
        
        guard var tempWord = title?.lowercased() else {
            return false
        }
        
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }
            else{
                return false
            }
        }
        
        return true
        
       
    }
    func isOriginal(word: String) -> Bool{
        
        return !usedWords.contains(word)
    }
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return mispelledRange.location == NSNotFound
        
    }
    
    func showErrorMessage (_ errorMessage : String, withTitle errorTitle: String){
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay!", style: .default))
        present(ac, animated: true)
        
    }
}

