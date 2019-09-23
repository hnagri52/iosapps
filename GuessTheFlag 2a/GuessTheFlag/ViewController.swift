//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Hussein Nagri on 2019-09-17.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questions = 0
    var picture = -1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(showScore))
        

        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        askQuestion()
        
    }
    
    @objc func showScore(){
        
        let scoreAction = UIAlertController(title: "SCORE", message: "Your score is \(score)", preferredStyle: .alert)
        scoreAction.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        present(scoreAction, animated: true)
    }

    func askQuestion(action: UIAlertAction! = nil){
        questions+=1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = "Tap on:\(countries[correctAnswer].uppercased())'s flag"
        
    }
    
    func restartGame(action: UIAlertAction! = nil){
        score = 0
        questions = 0
        
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title : String
        if (sender.tag == correctAnswer){
            title = "Correct!"
            score+=1
        }else{
            picture = sender.tag
            title = "Wrong! That's actually \(countries[picture].uppercased())'s flag!"
            score-=1
        }
        
        if (questions < 10){
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style:.default, handler: askQuestion))
            present(ac, animated: true)
        }
        else{
            let finalController = UIAlertController(title: "Game over!", message: "Your score is: \(score)." , preferredStyle:.alert)
                finalController.addAction(UIAlertAction(title: "Start a new game", style: .default, handler: restartGame))
                present(finalController, animated: true)
            
        }
       

        
        
    }
    
}

