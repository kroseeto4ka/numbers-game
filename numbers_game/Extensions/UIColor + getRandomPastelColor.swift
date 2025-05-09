//
//  UIColor + getRandomPastelColor.swift
//  numbers_game
//
//  Created by Никита Сорочинский on 5/9/25.
//

import UIKit.UIColor

extension UIColor {
    static func getRandomPastelColor() -> UIColor {
        return UIColor(
            hue: .random(in: 0...1),
            saturation: 0.7,
            brightness: 1.0,
            alpha: 1.0
        )
    }
}
