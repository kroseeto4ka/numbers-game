//
//  NumberManager.swift
//  numbers_game
//
//  Created by Никита Сорочинский on 5/8/25.
//
import Foundation

class NumberManager {
    var model: NumberModel = NumberModel()
    var action: (() -> ())?
    
    init() {
        self.generateData()
    }
    
    func checkAnswer(_ userResult: Int) -> Bool {
        if model.expectedResult == userResult { return true }
        
        return false
    }
    
    func getFirstNumber() -> String {
        if let firstNumber = model.firstNumber { return String(firstNumber) }
        
        return "ERROR"
    }
    
    func getSecondNumber() -> String {
        if let secondNumber = model.secondNumber { return String(secondNumber) }
        
        return "ERROR"
    }
    
    func getOperation() -> String {
        if let operation = model.operation {
            switch operation {
            case .division:
                return "÷"
            case .multiplication:
                return "×"
            case .minus:
                return "-"
            case .plus:
                return "+"
            }
        }
        
        return "ERROR"
    }
    
    func generateData() {
        self.model.operation = Operation.allCases.randomElement()!
        self.model.secondNumber = Int.random(in: 1...100)
        if self.model.operation == .division {
            self.model.firstNumber = self.model.secondNumber! * Int.random(in: 1...10)
        } else {
            self.model.firstNumber = Int.random(in: 1...100)
        }
    }
    
    
    
}
