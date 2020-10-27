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
    
    @Published private var model: MemoryGame<CardContent> = EmojiMemoryGameViewModel.createMemoryGame()
    
    // MARK: - Internal
    static func createMemoryGame() -> MemoryGame<CardContent> {
        
        let theme = ThemeManager.shared.getRandomTheme()
        let pickedRandEmojisNumber = Int.random(in: 2...theme.cards.count)
        
        return MemoryGame<CardContent>(numberOfPairsOfCards: pickedRandEmojisNumber, themeName: theme.name) { pairIndex in
            return theme.cards[pairIndex]
        }
    }
    
    // MARK: - Intents
    func createNewGame() {
        model = EmojiMemoryGameViewModel.createMemoryGame()
    }
    
    func choose(card: MemoryGame<CardContent>.Card) {
        model.choose(card: card)
    }
}
