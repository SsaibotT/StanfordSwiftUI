//
//  EmojyMemoryGame.swift
//  StanfordCS193SwiftUI
//
//  Created by Serhii Semenov on 19.07.2020.
//  Copyright © 2020 Serhii Semenov. All rights reserved.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    // MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Internal
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    @Published var color = ThemeManager.shared.themeColor
    
    static func createMemoryGame() -> MemoryGame<String> {
        
        ThemeManager.shared.createTheme()
        let emojis = ThemeManager.shared.emojis
        let color = ThemeManager.shared.themeColor
        
        let pickedRandEmojisNumber = Int.random(in: 2...emojis.count)
        
        return MemoryGame<String>(numberOfPairsOfCards: pickedRandEmojisNumber) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Intents
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

class ThemeManager {

    private init() {}
    static let shared = ThemeManager()
    
    var themeColor = Color.orange
    var emojis = ["👻", "🎃", "💩", "👺", "👾"]
    
    func createTheme() {
        guard let theme = arrayOfThemes().randomElement() else { return }
        
        themeColor = theme.color
        emojis = theme.emojis
    }
    
    func arrayOfThemes() -> [Theme] {
        let haloweenTheme = Theme(color: Color.orange, emojis: ["👻", "🎃", "💩", "👺", "👾"], name: "Haloween")
        let animalTheme = Theme(color: Color.green, emojis: ["🐶", "🐰", "🐌", "🐒", "🐨"], name: "Animal")
        let sportTheme = Theme(color: Color.blue, emojis: ["⚽️", "🏀", "🏈", "⚾️", "🏐"], name: "Sport")
        
        let arrayOfThemes = [haloweenTheme, animalTheme, sportTheme]
        return arrayOfThemes
    }
}

struct Theme {
    
    var color: Color
    var emojis: [String]
    var name: String
}
