//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Евгений Мелешков on 13.01.2021.
//

import UIKit

enum Mode {
    case flashCards
    case quiz
}

enum State {
    case question
    case answer
}




class ViewController: UIViewController, UITextFieldDelegate {

    
    var mode: Mode = .flashCards {
        didSet {
                updateUI()
            }
    }
    var state: State = .question
    
    
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    
    let elementList = ["Carbon", "Gold", "Chlorine",
       "Sodium"]
    var currentElementIndex = 0
    
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var modeSelector: UISegmentedControl!
    
    @IBOutlet weak var textField: UITextField!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.3199654862, green: 0.3402632928, blue: 0.2938381603, alpha: 1)
        updateUI()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func switchModes(_ sender: Any) {
        if modeSelector.selectedSegmentIndex == 0 {
                mode = .flashCards
            } else {
                mode = .quiz
            }
        }
    
   
    @IBAction func showAnswer(_ sender: Any) {
        state = .answer
        updateUI()
    }
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1
        if currentElementIndex >= elementList.count {
            currentElementIndex = 0
        }
        state = .question
        updateUI()
    }
    
    
    
    
    func updateFlashCardUI(elementName: String) {
        textField.isHidden = true
        textField.resignFirstResponder()
        
        if state == .question {
        answerLabel.text = "?"
        } else if state == .answer {
            answerLabel.text = elementList[currentElementIndex]
        }
    }
    
    func updateQuizUI(elementName: String) {
        textField.isHidden = false
        switch state {
        case .question:
            answerLabel.text = ""
            textField.becomeFirstResponder()
        case .answer:
            textField.resignFirstResponder()
        }
        
        switch state {
        case .question:
            answerLabel.text = ""
        case .answer:
            if answerIsCorrect {
                answerLabel.text = "Correct!"
            } else {
                answerLabel.text = "❌"
            }
        }
        
    }
    
    func updateUI() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        imageView.image = image
        switch mode {
        case .flashCards:
            updateFlashCardUI(elementName: elementName)
        case .quiz:
            updateQuizUI(elementName: elementName)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldContents = textField.text!
        if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
        } else {
            answerIsCorrect = false
        }
        
        if answerIsCorrect {
            print("Correct!")
        } else {
            print("❌")
        }
        state = .answer
        updateUI()
        return true
    }
    
}


