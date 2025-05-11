//
//  ViewController.swift
//  numbers_game
//
//  Created by Никита Сорочинский on 5/8/25.
//

import UIKit

class ViewController: UIViewController {
    
    let numberHorizontalStack = UIStackView()
    let buttonHorizontalStack = UIStackView()
    let firstNumberLabel = UILabel()
    let secondNumberLabel = UILabel()
    let operationLabel = UILabel()
    let equalLabel = UILabel()
    let stateLabel = UILabel()
    let goButton = UIButton()
    let resetButton = UIButton()
    let highscoreLabel = UILabel()
    
    let resultField = UITextField()
    
    var manager = NumberManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
}

//MARK: - Setup View
extension ViewController {
    func setupView() {
        view.backgroundColor = .systemGray4
        
        setupHighScoreLabel()
        setupNumberStack()
        setupButtonStack()
        setupEqualLabel()
        setupStateLabel()
        setupResultField()
        addAction()
        
        view.addSubview(highscoreLabel)
        view.addSubview(numberHorizontalStack)
        view.addSubview(equalLabel)
        view.addSubview(buttonHorizontalStack)
        view.addSubview(stateLabel)
        view.addSubview(resultField)
    }
    
    func setupHighScoreLabel() {
        highscoreLabel.text = "Stack: \(manager.getHighscore())"
        highscoreLabel.textColor = .black
        highscoreLabel.font = .systemFont(ofSize: 20)
        highscoreLabel.textAlignment = .center
    }
    
    func setupNumberStack() {
        numberHorizontalStack.axis = .horizontal
        numberHorizontalStack.alignment = .center
        numberHorizontalStack.distribution = .fillEqually
        numberHorizontalStack.spacing = 0
        
        setupFirstNumberLabel()
        setupOperationLabel()
        setupSecondNumberLabel()
        
        numberHorizontalStack.addArrangedSubview(firstNumberLabel)
        numberHorizontalStack.addArrangedSubview(operationLabel)
        numberHorizontalStack.addArrangedSubview(secondNumberLabel)
    }
    
    func setupButtonStack() {
        buttonHorizontalStack.axis = .horizontal
        buttonHorizontalStack.alignment = .center
        buttonHorizontalStack.distribution = .fillEqually
        buttonHorizontalStack.spacing = 10
        
        setupGoButton()
        setupResetButton()
        
        buttonHorizontalStack.addArrangedSubview(goButton)
        buttonHorizontalStack.addArrangedSubview(resetButton)
    }
    
    func setupFirstNumberLabel() {
        firstNumberLabel.text = manager.getFirstNumber()
        firstNumberLabel.textColor = UIColor.getRandomPastelColor()
        firstNumberLabel.font = UIFont.getRandomCustomFont(50)
        firstNumberLabel.textAlignment = .center
    }
    
    func setupSecondNumberLabel() {
        secondNumberLabel.text = manager.getSecondNumber()
        secondNumberLabel.textColor = UIColor.getRandomPastelColor()
        secondNumberLabel.font = UIFont.getRandomCustomFont(50)
        secondNumberLabel.textAlignment = .center
    }
    
    func setupOperationLabel() {
        operationLabel.text = manager.getOperation()
        operationLabel.textColor = .black
        operationLabel.font = .systemFont(ofSize: 50)
        operationLabel.textAlignment = .center
    }
    
    func setupEqualLabel() {
        equalLabel.text = "="
        equalLabel.textColor = .black
        equalLabel.font = .systemFont(ofSize: 50)
        equalLabel.textAlignment = .center
    }
    
    func setupResultField() {
        resultField.text = nil
        resultField.placeholder = "Введите ответ..."
        resultField.borderStyle = .roundedRect
        resultField.textAlignment = .center
        resultField.keyboardType = .numbersAndPunctuation
    }
    
    func setupStateLabel() {
        stateLabel.font = .boldSystemFont(ofSize: 30)
        stateLabel.textAlignment = .center
        stateLabel.isHidden = true
    }
    
    func setupGoButton() {
        goButton.setTitle("Go!", for: .normal)
        goButton.tintColor = .black
        goButton.backgroundColor = .systemGreen
        goButton.layer.cornerRadius = 10
    }
    
    func setupResetButton() {
        resetButton.setTitle("Reset", for: .normal)
        resetButton.tintColor = .black
        resetButton.backgroundColor = .systemRed
        resetButton.layer.cornerRadius = 10
    }
    
    func updateViewAfterReset() {
        highscoreLabel.text = "Stack: \(manager.getHighscore())"
        
        firstNumberLabel.text = manager.getFirstNumber()
        firstNumberLabel.textColor = UIColor.getRandomPastelColor()
        firstNumberLabel.font = UIFont.getRandomCustomFont(50)
        
        secondNumberLabel.text = manager.getSecondNumber()
        secondNumberLabel.textColor = UIColor.getRandomPastelColor()
        secondNumberLabel.font = UIFont.getRandomCustomFont(50)
        
        operationLabel.text = manager.getOperation()
        operationLabel.textColor = .black
        operationLabel.font = .systemFont(ofSize: 50)
        
        resultField.text = nil
        
        stateLabel.isHidden = true
    }
    
    func addAction() {
        let goAction = UIAction { _ in
            if let result = self.resultField.text {
                if self.manager.checkAnswer(Int(result) ?? 0) {
                    self.stateLabel.isHidden = false
                    self.stateLabel.text = "Right!"
                    self.stateLabel.textColor = .green
                    self.manager.increaseHighScore()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.manager.generateData()
                        self.updateViewAfterReset()
                    }
                } else {
                    self.stateLabel.isHidden = false
                    self.stateLabel.text = "Wrong!"
                    self.stateLabel.textColor = .red
                    self.manager.resetHighScore()
                    self.highscoreLabel.text = "Stack: \(self.manager.getHighscore())"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.stateLabel.isHidden = true
                    }
                }
            }
        }
        let resetAction = UIAction { _ in
            self.manager.generateData()
            self.manager.resetHighScore()
            self.updateViewAfterReset()
        }
        
        goButton.addAction(goAction, for: .touchUpInside)
        resetButton.addAction(resetAction, for: .touchUpInside)
    }
}

//MARK: - Setup layout
extension ViewController {
    func setupLayout() {
        highscoreLabel.translatesAutoresizingMaskIntoConstraints = false
        numberHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        buttonHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        firstNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        operationLabel.translatesAutoresizingMaskIntoConstraints = false
        secondNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        equalLabel.translatesAutoresizingMaskIntoConstraints = false
        resultField.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        goButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highscoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            highscoreLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            highscoreLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            highscoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            numberHorizontalStack.topAnchor.constraint(equalTo: highscoreLabel.bottomAnchor, constant: 20),
            numberHorizontalStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10),
            numberHorizontalStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            numberHorizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            equalLabel.topAnchor.constraint(equalTo: numberHorizontalStack.bottomAnchor, constant: 20),
            equalLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            equalLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            equalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stateLabel.topAnchor.constraint(equalTo: equalLabel.bottomAnchor, constant: 20),
            stateLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            stateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonHorizontalStack.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 30),
            buttonHorizontalStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            buttonHorizontalStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            buttonHorizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resultField.topAnchor.constraint(equalTo: buttonHorizontalStack.bottomAnchor, constant: 20),
            resultField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            resultField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            resultField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
