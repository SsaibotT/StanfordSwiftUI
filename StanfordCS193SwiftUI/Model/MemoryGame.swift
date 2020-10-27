//
//  MemoryGame.swift
//  StanfordCS193SwiftUI
//
//  Created by Serhii Semenov on 19.07.2020.
//  Copyright © 2020 Serhii Semenov. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    var gameContent = GameContent(themeName: "", cards: [MemoryGame.Card](), points: 0)
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { gameContent.cards.indices.filter { gameContent.cards[$0].isFaceUp }.only }
        set { gameContent.cards.indices.forEach { gameContent.cards[$0].isFaceUp = $0 == newValue } }
    }
    
    init(numberOfPairsOfCards: Int, themeName: String, cardContentFactory: (Int) -> CardContent) {
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex) //function that returns cardContent

            gameContent.cards.append(Card(content: content, id: pairIndex * 2))
            gameContent.cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        gameContent.cards.shuffle()
        gameContent.themeName = themeName
    }
    
    mutating func choose(card: Card) {
        print("chosen card: \(card)")
        
        guard let chosenIndex = gameContent.cards.firstIndex(matching: card) else { return }
        guard !gameContent.cards[chosenIndex].isFaceUp else { return }

        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if gameContent.cards[chosenIndex].content == gameContent.cards[potentialMatchIndex].content {
                gameContent.cards[chosenIndex].isMatched = true
                gameContent.cards[potentialMatchIndex].isMatched = true
                
                gameContent.points += 2
            } else {
                gameContent.points -= 1
            }
            self.gameContent.cards[chosenIndex].isFaceUp = true
        } else {

            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
    }
    
    struct GameContent {
        var themeName: String
        var cards: [Card]
        var points: Int
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
}
