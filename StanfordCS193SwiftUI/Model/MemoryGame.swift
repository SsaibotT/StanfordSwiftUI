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
    var cards: [Card]
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue } }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)

            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        print("chosen card: \(card)")
        
        guard let chosenIndex = cards.firstIndex(matching: card) else { return }
        guard !cards[chosenIndex].isFaceUp else { return }

        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
            }
            self.cards[chosenIndex].isFaceUp = true
        } else {

            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
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
