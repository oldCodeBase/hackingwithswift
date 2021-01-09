//
//  ViewController.swift
//  Project-02
//
//  Created by Ibragim Akaev on 24/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var buttonOne: UIButton!
    @IBOutlet var buttonTwo: UIButton!
    @IBOutlet var buttonThree: UIButton!
    
    // MARK: - Private properties
    private var countries = ["estonia", "france", "germany", "ireland",
                             "italy", "monaco", "nigeria", "poland",
                             "russia", "spain", "uk", "us"]
    private var score = 0
    private var answers = 0
    private var correctAnswer = 0
    
    // MARK: - Ovveride methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(shareTapped))
        
        askQuestion(action: nil)
    }
    
    // MARK: - IBActions
    @IBAction func buttonTapped(_ sender: UIButton) {
        gameLogic(button: sender)
    }

}

extension ViewController {
    
    // MARK: - Private methods
    private func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        setAttributesForButtons()
        
        title = "\(countries[correctAnswer].uppercased()) Score: \(score)"
    }
    
    private func setAttributesForButtons() {
        
        buttonOne.setImage(UIImage(named: countries[0]), for: .normal)
        buttonTwo.setImage(UIImage(named: countries[1]), for: .normal)
        buttonThree.setImage(UIImage(named: countries[2]), for: .normal)
        
        buttonOne.layer.borderWidth = 1
        buttonTwo.layer.borderWidth = 1
        buttonThree.layer.borderWidth = 1
        
        buttonOne.layer.borderColor = UIColor.lightGray.cgColor
        buttonTwo.layer.borderColor = UIColor.lightGray.cgColor
        buttonThree.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func gameLogic(button: UIButton) {
        answers += 1
        var title: String
        var message: String
        
        if answers == 10 {
            if button.tag == correctAnswer {
                message = "Your final score is: \(score + 1)"
            } else {
                message = "Your final score is: \(score - 1)"
            }
            title = "End of the Game"
            answers = 0
            score = 0
        } else if button.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = """
                    Wrong!
                    That’s the flag of \(countries[button.tag].uppercased())
                    """
            
            score -= 1
            message = "Your score is \(score)"
        }
        
        showAllert(title: title, message: message)
    }
    
    private func showAllert(title: String, message: String) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .default,
                                      handler: askQuestion))
        
        present(alert, animated: true)
    }
    
    @objc func shareTapped() {
        showAllert(title: "Your score is \(score)", message: "")
    }
}

