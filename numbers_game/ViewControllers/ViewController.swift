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
    let scoresHorizontalStack = UIStackView()
    let firstNumberLabel = UILabel()
    let secondNumberLabel = UILabel()
    let operationLabel = UILabel()
    let equalLabel = UILabel()
    let stateLabel = UILabel()
    let recordLabel = UILabel()
    let goButton = UIButton()
    let resetButton = UIButton()
    let highscoreLabel = UILabel()
    
    let resultField = UITextField()
    
    let manager = NumberManager()

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
        
        setupScoreStack()
        setupNumberStack()
        setupButtonStack()
        setupEqualLabel()
        setupResultField()
        setupStateLabel()
        addAction()
        
        view.addSubview(scoresHorizontalStack)
        view.addSubview(numberHorizontalStack)
        view.addSubview(equalLabel)
        view.addSubview(buttonHorizontalStack)
        view.addSubview(stateLabel)
        view.addSubview(resultField)
    }
    
    func setupHighScoreLabel() {
        highscoreLabel.text = "\(Texts.stack)\(manager.getHighscore())"
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
    
    func setupScoreStack() {
        scoresHorizontalStack.axis = .horizontal
        scoresHorizontalStack.alignment = .center
        scoresHorizontalStack.distribution = .fillEqually
        scoresHorizontalStack.spacing = 0
        
        setupHighScoreLabel()
        setupRecordLabel()
        
        scoresHorizontalStack.addArrangedSubview(highscoreLabel)
        scoresHorizontalStack.addArrangedSubview(recordLabel)
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
        resultField.placeholder = Texts.inputTextholder
        resultField.borderStyle = .roundedRect
        resultField.textAlignment = .center
        resultField.keyboardType = .numbersAndPunctuation
    }
    
    func setupStateLabel() {
        stateLabel.font = .boldSystemFont(ofSize: 30)
        stateLabel.textAlignment = .center
        stateLabel.isHidden = true
    }
    
    func setupRecordLabel() {
        recordLabel.text = "\(Texts.record)\(manager.getRecord())"
        recordLabel.textColor = .black
        recordLabel.font = .systemFont(ofSize: 20)
        recordLabel.textAlignment = .center
    }
    
    func setupGoButton() {
        goButton.setTitle(Texts.goButton, for: .normal)
        goButton.tintColor = .black
        goButton.backgroundColor = .systemGreen
        goButton.layer.cornerRadius = 10
    }
    
    func setupResetButton() {
        resetButton.setTitle(Texts.resetButton, for: .normal)
        resetButton.tintColor = .black
        resetButton.backgroundColor = .systemRed
        resetButton.layer.cornerRadius = 10
    }
    
    func updateViewAfterReset() {
        highscoreLabel.text = "\(Texts.stack)\(manager.getHighscore())"
        
        recordLabel.text = "\(Texts.record)\(manager.getRecord())"
        
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
    
    func goActionSetup() {
        if let result = self.resultField.text {
            if self.manager.checkAnswer(Int(result) ?? 0) {
                self.stateLabel.isHidden = false
                self.stateLabel.text = Texts.right
                self.stateLabel.textColor = .green
                self.manager.increaseHighScore()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.manager.generateData()
                    self.updateViewAfterReset()
                }
            } else {
                self.stateLabel.isHidden = false
                self.stateLabel.text = Texts.wrong
                self.stateLabel.textColor = .red
                self.manager.resetHighScore()
                self.highscoreLabel.text = "\(Texts.stack)\(self.manager.getHighscore())"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.stateLabel.isHidden = true
                }
            }
        }
    }
    
    func addAction() {
        let goAction = UIAction { _ in
            self.goActionSetup()
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
        scoresHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        numberHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        buttonHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        equalLabel.translatesAutoresizingMaskIntoConstraints = false
        resultField.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scoresHorizontalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            scoresHorizontalStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            scoresHorizontalStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            scoresHorizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            numberHorizontalStack.topAnchor.constraint(equalTo: scoresHorizontalStack.bottomAnchor, constant: 20),
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
