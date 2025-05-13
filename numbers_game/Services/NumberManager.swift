//
//  NumberManager.swift
//  numbers_game
//
//  Created by Никита Сорочинский on 5/8/25.
//
class NumberManager {
    var model: NumberModel = NumberModel()
    
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
    
    func getHighscore() -> Int {
        guard let highScore = model.highScore else { return 0 }
        return highScore
    }
    
    func getRecord() -> Int {
        guard let record = model.record else { return 0 }
        return record
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
    
    func resetHighScore() {
        self.model.highScore = 0
    }
    
    func increaseHighScore() {
        if let highScore = model.highScore {
            model.highScore! += 1
            checkRecord(model.highScore)
        } else {
            model.highScore = 1
            checkRecord(model.highScore)
        }
    }
    
    func checkRecord(_ highScore: Int?) {
        if let highScore = highScore {
            if highScore > model.record ?? 0 {
                model.record = model.highScore!
            }
        }
    }
}
