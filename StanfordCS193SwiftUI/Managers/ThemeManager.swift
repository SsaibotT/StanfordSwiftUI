//
//  ThemeManager.swift
//  StanfordCS193SwiftUI
//
//  Created by Serhii Semenov on 24.09.2020.
//  Copyright © 2020 Serhii Semenov. All rights reserved.
//

import Foundation
import SwiftUI

class ThemeManager {

    private init() {}
    static let shared = ThemeManager()
    
    func getRandomTheme() -> Theme {

        let halloweenTheme = generateTheme(emojis: ["👻", "🎃", "💩", "👺", "👾"], color: .orange)
        let animalTheme = generateTheme(emojis: ["🐶", "🐰", "🐌", "🐒", "🐨"], color: .green)
        let sportTheme = generateTheme(emojis: ["⚽️", "🏀", "🏈", "⚾️", "🏐"], color: .blue)
        
        
        let randomTheme = [Theme(name: "Halloween", cards: halloweenTheme),
                           Theme(name: "Animal", cards: animalTheme),
                           Theme(name: "Sport", cards: sportTheme)]
            .randomElement()!
        
        print("some new code")
        return randomTheme
    }
    
    private func generateTheme(emojis: [String], color: Color) -> [CardContent] {
        var content = [CardContent]()
        for emoji in emojis {
            content.append(CardContent(emoji: emoji, color: color))
        }
        
        return content
    }
}
