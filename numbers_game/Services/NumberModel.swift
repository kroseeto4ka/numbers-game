//
//  NumberModel.swift
//  numbers_game
//
//  Created by Никита Сорочинский on 5/8/25.
//

struct NumberModel {
    var firstNumber: Int?
    var secondNumber: Int?
    var operation: Operation?
    var userResult: Int?
    var expectedResult: Int? {
        if let firstNumber, let secondNumber, let operation {
            switch operation {
            case .plus:
                return firstNumber + secondNumber
            case .minus:
                return firstNumber - secondNumber
            case .division:
                return firstNumber / secondNumber
            case .multiplication:
                return firstNumber * secondNumber
            }
        }
        
        return nil
    }
}
