//
//  EmojyMemoryGame.swift
//  StanfordCS193SwiftUI
//
//  Created by Serhii Semenov on 19.07.2020.
//  Copyright © 2020 Serhii Semenov. All rights reserved.
//

import Foundation
import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    
    // MARK: - Access to the Model
    var gameContent: MemoryGame<CardContent>.GameContent {
        return model.gameContent
    }
    
    // MARK: - Internal
    @Published private var model: MemoryGame<CardContent> = EmojiMemoryGameViewModel.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<CardContent> {
        
        let theme = ThemeManager.shared.getRandomTheme()
        let pickedRandEmojisNumber = Int.random(in: 2...theme.cards.count)
        
        return MemoryGame<CardContent>(numberOfPairsOfCards: pickedRandEmojisNumber, themeName: theme.name) { pairIndex in
            return theme.cards[pairIndex]
        }
    }
    
    // MARK: - Intents
    func choose(card: MemoryGame<CardContent>.Card) {
        model.choose(card: card)
    }
}
