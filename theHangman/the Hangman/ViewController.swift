
import UIKit

class ViewController: UIViewController {
    // Properties
    var titleLabel: UILabel!
    var reportLabel: UILabel!
    var scoreLabel: UILabel!
    var wrongAnswersLabel: UILabel!
    
    var currentAnswer: UITextField!
    var chosenLetter: UILabel!
    
    var letterButtons = [UIButton]()
    var tappedButtons = [UIButton]()
    
    var guessedLetters = 0
    var attemptsLeft = 0
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var errorScore = 0 {
        didSet {
            wrongAnswersLabel.text = "Wrong answers: \(errorScore)."
        }
    }
    
    var word = ""
    var usedLetters = [Character]()
    var promptWord = [String]()
    
    //  View management
    override func loadView() {
        //View's creation
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        wrongAnswersLabel = UILabel()
        wrongAnswersLabel.translatesAutoresizingMaskIntoConstraints = false
        wrongAnswersLabel.textAlignment = .right
        wrongAnswersLabel.text = "Wrong answers: 0"
        view.addSubview(wrongAnswersLabel)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 44)
        titleLabel.textAlignment = .center
        titleLabel.text = "the Hangman"
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(titleLabel)
        
        reportLabel = UILabel()
        reportLabel.translatesAutoresizingMaskIntoConstraints = false
        reportLabel.font = UIFont.systemFont(ofSize: 24)
        reportLabel.text = "REPORT"
        reportLabel.numberOfLines = 0
        reportLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(reportLabel)
        
        let nextWord = UIButton(type: .system)
        nextWord.translatesAutoresizingMaskIntoConstraints = false
        nextWord.setTitle("NEXT WORD", for: .normal)
        nextWord.addTarget(self, action: #selector(nextWordTapped), for: .touchUpInside)
        view.addSubview(nextWord)
        
        let retry = UIButton(type: .system)
        retry.translatesAutoresizingMaskIntoConstraints = false
        retry.setTitle("RETRY", for: .normal)
        retry.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        view.addSubview(retry)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        chosenLetter = UILabel()
        chosenLetter.translatesAutoresizingMaskIntoConstraints = false
        chosenLetter.font = UIFont.systemFont(ofSize: 44)
        chosenLetter.text = "_"
        chosenLetter.textAlignment = .center
        view.addSubview(chosenLetter)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.darkGray.cgColor
        view.addSubview(buttonsView)
        
        // Constraints creation
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            wrongAnswersLabel.topAnchor.constraint(equalTo: scoreLabel.topAnchor),
            wrongAnswersLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scoreLabel.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            reportLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            reportLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reportLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            
            nextWord.topAnchor.constraint(equalTo: reportLabel.bottomAnchor, constant: 10),
            nextWord.leadingAnchor.constraint(equalTo: reportLabel.leadingAnchor),
            nextWord.trailingAnchor.constraint(equalTo: retry.leadingAnchor),
            nextWord.widthAnchor.constraint(lessThanOrEqualTo: reportLabel.widthAnchor, multiplier: 0.5),
            nextWord.heightAnchor.constraint(equalToConstant: 44),
            
            retry.topAnchor.constraint(equalTo: nextWord.topAnchor),
            retry.trailingAnchor.constraint(equalTo: reportLabel.trailingAnchor),
            retry.leadingAnchor.constraint(equalTo: nextWord.trailingAnchor),
            retry.widthAnchor.constraint(lessThanOrEqualTo: reportLabel.widthAnchor, multiplier: 0.5),
            retry.heightAnchor.constraint(equalToConstant: 44),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: reportLabel.widthAnchor),
            currentAnswer.topAnchor.constraint(equalTo: nextWord.bottomAnchor, constant: 20),
            currentAnswer.heightAnchor.constraint(equalToConstant: 88),
            
            chosenLetter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chosenLetter.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 15),
            chosenLetter.widthAnchor.constraint(equalToConstant: 44),
            
            submit.centerYAnchor.constraint(equalTo: chosenLetter.centerYAnchor),
            submit.leadingAnchor.constraint(equalTo: currentAnswer.leadingAnchor),
            submit.heightAnchor.constraint(equalToConstant: 44),
            submit.trailingAnchor.constraint(equalTo: chosenLetter.leadingAnchor, constant: -15),
            
            clear.centerYAnchor.constraint(equalTo: chosenLetter.centerYAnchor),
            clear.trailingAnchor.constraint(equalTo: currentAnswer.trailingAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            clear.leadingAnchor.constraint(equalTo: chosenLetter.trailingAnchor, constant: 15),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 1040),
            buttonsView.heightAnchor.constraint(equalToConstant: 160),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: chosenLetter.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])

        // - views borders
        let labels = [titleLabel, reportLabel, chosenLetter]
        for label in labels {
            label!.layer.borderWidth = 1
            label!.layer.borderColor = UIColor.darkGray.cgColor
        }

        let buttons = [nextWord, retry, submit, clear]
        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.darkGray.cgColor
        }
        
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.darkGray.cgColor
        currentAnswer.layer.borderWidth = 1
        currentAnswer.layer.borderColor = UIColor.darkGray.cgColor

        
        //  - Buttons creation
        let width = 80
        let height = 80
        
        for row in 0 ..< 2 {
            for column in 0 ..< 13 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("W", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
        // Generate letters
        let allLetters = (65...90).map { Character(Unicode.Scalar($0)) }

        for (index, button) in letterButtons.enumerated() {
            button.setTitle(String(allLetters[index]), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWords()
    }
    

    // Load the words from Bundle
    @objc func loadWords() {
        if let wordlistURL = Bundle.main.url(forResource: "wordlist", withExtension: "txt") {
            if let wordlistContent = try? String(contentsOf: wordlistURL) {
                var words = wordlistContent.components(separatedBy: "\n")
                words.shuffle()
                
                word = words.randomElement()!
                print("Word: \(word)")
                
                for letter in word {
                    usedLetters.append(letter)
                    promptWord.append("?")
                }
                print("Used letters: \(usedLetters)")
                print("Prompt word: \(promptWord)")
                
                currentAnswer.text = promptWord.joined()
                attemptsLeft = word.count / 4 * 3
            }
        }
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }

        chosenLetter.text = buttonTitle
        
        tappedButtons.append(sender)
        sender.isHidden = true
        sender.isUserInteractionEnabled = false
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let stringLetter = chosenLetter.text?.lowercased() else { return }
        
        if usedLetters.contains(Character(stringLetter)) {
            for (index, character) in usedLetters.enumerated() {
                if character == Character(stringLetter) {
                    promptWord[index] = stringLetter
                    currentAnswer.text = promptWord.joined().uppercased()
                    guessedLetters += 1
                    score += 1
                    chosenLetter.text = "_"
                    if guessedLetters == word.count {
                        let victoryAC = UIAlertController(title: "Congratulations!", message: "You survived!", preferredStyle: .alert)
                        victoryAC.addAction(UIAlertAction(title: "Move on!", style: .default, handler: nextWord))
                        present(victoryAC, animated: true)
                    }
                }
            }
        } else {
            errorScore += 1
            if errorScore <= attemptsLeft {
                let errorAC = UIAlertController(title: "WRONG", message: "Choose another letter!", preferredStyle: .alert)
                errorAC.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    self.chosenLetter.text = "_"
                })
                present(errorAC, animated: true, completion: nil)
            } else {
                let gameOverAC = UIAlertController(title: "GAME OVER", message: "You are dead!", preferredStyle: .alert)
                gameOverAC.addAction(UIAlertAction(title: "Try again", style: .default, handler: retry))
                present(gameOverAC, animated: true)
            }
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        let lastButton = tappedButtons.removeLast()
        lastButton.isHidden = false
        lastButton.isUserInteractionEnabled = true
        chosenLetter.text = "_"
    }
    
    @objc func nextWordTapped(_ sender: UIButton) {
        nextWord()
    }
    
    @objc func retryTapped(_ sender: UIButton) {
        retry()
        
    }
    
    func retry(action: UIAlertAction! = nil) {
        score = 0
        errorScore = 0
        promptWord.removeAll()
        
        for _ in word {
            promptWord.append("?")
        }
        
        showButtons()
        currentAnswer.text = promptWord.joined()
        chosenLetter.text = "_"
    }
    
    func nextWord(action: UIAlertAction! = nil) {
        word = ""
        promptWord.removeAll()
        usedLetters.removeAll()
        showButtons()
        score = 0
        errorScore = 0
        loadWords()
    }
    
    func showButtons() {
        for button in tappedButtons {
            button.isHidden = false
            button.isUserInteractionEnabled = true
        }
    }
}

//  - Old code
// Old nextWordTapped method
/*
@objc func nextWordTapped(_ sender: UIButton) {
    word = ""
    promptWord = ""
    usedLetters = []
    loadWords()
}
*/
// Old loadWord method
/*
@objc func loadWords() {
    if let wordlistURL = Bundle.main.url(forResource: "wordlist", withExtension: "txt") {
        if let wordlistContent = try? String(contentsOf: wordlistURL) {
            var words = wordlistContent.components(separatedBy: "\n")
            words.shuffle()
            
            word = words.randomElement()!
            print("Word: \(word)")
            
            for letter in word {
                usedLetters.append(String(letter))
                promptWord += "?"
 
            }
            print("Used letters: \(usedLetters)")
            print("Prompt word: \(promptWord)")
            
            currentAnswer.text = promptWord
 
        }
    }
}
*/
// Old submit method
/*
if usedLetters.contains(stringLetter) {
    let character = Character(stringLetter)
    
    for letter in word {
        if letter == character {
            if let position = word.firstIndex(of: letter) {
                promptWord.remove(at: position)
                promptWord.insert(letter, at: position)
            }
        }
        currentAnswer.text = promptWord.uppercased()
    }
} else {
    let alertController = UIAlertController(title: "WRONG", message: "Choose another letter!", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
        self.chosenLetter.text = "_"
    })
    present(alertController, animated: true, completion: nil)
}
 */
