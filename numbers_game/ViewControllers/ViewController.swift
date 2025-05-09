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
        horizontalStack.spacing = 0
        
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
        firstNumberLabel.font = createRandomCustomFont(50)
        firstNumberLabel.textAlignment = .center
    }
    
    func setupSecondNumberLabel() {
        secondNumberLabel.text = manager.getSecondNumber()
        secondNumberLabel.textColor = .black
        secondNumberLabel.font = createRandomCustomFont(50)
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
        resultField.keyboardType = .
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
    
    func createRandomCustomFont(_ size: CGFloat) -> UIFont {
        let randomName: CustomFonts = CustomFonts.allCases.randomElement()!
        return UIFont(name: randomName.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
    func addAction() {
        let action = UIAction { _ in
            if let result = self.resultField.text {
                if self.manager.checkAnswer(Int(result) ?? 0) {
                    self.stateLabel.isHidden = false
                    self.stateLabel.text = "Right!"
                    self.stateLabel.textColor = .green
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.manager.generateData()
                        self.setupView()
                    }
                } else {
                    self.stateLabel.isHidden = false
                    self.stateLabel.text = "Wrong!"
                    self.stateLabel.textColor = .red
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.stateLabel.isHidden = true
                    }
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
            horizontalStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10),
            horizontalStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            horizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            equalLabel.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 20),
            equalLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            equalLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            equalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stateLabel.topAnchor.constraint(equalTo: equalLabel.bottomAnchor, constant: 20),
            stateLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            stateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            goButton.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 30),
            goButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            goButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resultField.topAnchor.constraint(equalTo: goButton.bottomAnchor, constant: 20),
            resultField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            resultField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            resultField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
