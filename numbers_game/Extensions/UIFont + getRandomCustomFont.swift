//
//  UIFont + getRandomCustomFont.swift
//  numbers_game
//
//  Created by Никита Сорочинский on 5/9/25.
//

import UIKit.UIFont

extension UIFont {
    static func getRandomCustomFont(_ size: CGFloat) -> UIFont {
        let randomName: CustomFonts = CustomFonts.allCases.randomElement()!
        return UIFont(name: randomName.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
