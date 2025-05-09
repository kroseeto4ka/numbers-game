//
//  ViewController.swift
//  numbers_game
//
//  Created by Никита Сорочинский on 5/8/25.
//

import UIKit

class ViewController: UIViewController {
    
    let horizontalStack = UIStackView()
    let firstNumberLabel = UILabel()
    let secondNumberLabel = UILabel()
    let operationLabel = UILabel()
    let equalLabel = UILabel()
    let stateLabel = UILabel()
    let goButton = UIButton()
    
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
        
        setupHorizontalStack()
        setupEqualLabel()
        setupWrongLabel()
        setupGoButton()
        setupResultField()
        addAction()
        
        view.addSubview(horizontalStack)
        view.addSubview(equalLabel)
        view.addSubview(stateLabel)
        view.addSubview(goButton)
        view.addSubview(resultField)
    }
    
    func setupHorizontalStack() {
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = 30
        
        setupFirstNumberLabel()
        setupOperationLabel()
        setupSecondNumberLabel()
        
        horizontalStack.addArrangedSubview(firstNumberLabel)
        horizontalStack.addArrangedSubview(operationLabel)
        horizontalStack.addArrangedSubview(secondNumberLabel)
    }
    
    func setupFirstNumberLabel() {
        firstNumberLabel.text = manager.getFirstNumber()
        firstNumberLabel.textColor = .black
        firstNumberLabel.font = .systemFont(ofSize: 30)
        firstNumberLabel.textAlignment = .center
    }
    
    func setupSecondNumberLabel() {
        secondNumberLabel.text = manager.getSecondNumber()
        secondNumberLabel.textColor = .black
        secondNumberLabel.font = .systemFont(ofSize: 30)
        secondNumberLabel.textAlignment = .center
    }
    
    func setupOperationLabel() {
        operationLabel.text = manager.getOperation()
        operationLabel.textColor = .black
        operationLabel.font = .systemFont(ofSize: 30)
        operationLabel.textAlignment = .center
    }
    
    func setupEqualLabel() {
        equalLabel.text = "="
        equalLabel.textColor = .black
        equalLabel.font = .systemFont(ofSize: 30)
        equalLabel.textAlignment = .center
    }
    
    func setupResultField() {
        resultField.text = nil
        resultField.placeholder = "Введите ответ..."
        resultField.borderStyle = .roundedRect
        resultField.textAlignment = .center
        resultField.keyboardType = .numberPad
    }
    
    func setupWrongLabel() {
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
    
    func addAction() {
        let action = UIAction { _ in
            if let result = self.resultField.text {
                if self.manager.checkAnswer(Int(result) ?? 0) {
                    self.stateLabel.isHidden = false
                    self.stateLabel.text = "Right!"
                    self.stateLabel.textColor = .green
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.manager.generateData()
                        self.setupView()
                    }
                } else {
                    self.stateLabel.isHidden = false
                    self.stateLabel.text = "Wrong!"
                    self.stateLabel.textColor = .red
                }
            }
        }
        goButton.addAction(action, for: .touchUpInside)
    }
}

//MARK: - Setup layout
extension ViewController {
    func setupLayout() {
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        firstNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        operationLabel.translatesAutoresizingMaskIntoConstraints = false
        secondNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        equalLabel.translatesAutoresizingMaskIntoConstraints = false
        resultField.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        goButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            horizontalStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            horizontalStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            horizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            equalLabel.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 30),
            equalLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            equalLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            equalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stateLabel.topAnchor.constraint(equalTo: equalLabel.bottomAnchor, constant: 30),
            stateLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            stateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            goButton.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 30),
            goButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            goButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resultField.topAnchor.constraint(equalTo: goButton.bottomAnchor, constant: 20),
            resultField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            resultField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            resultField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
