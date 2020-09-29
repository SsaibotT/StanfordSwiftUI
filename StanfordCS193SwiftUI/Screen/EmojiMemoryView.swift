//
//  ContentView.swift
//  StanfordCS193SwiftUI
//
//  Created by Serhii Semenov on 19.07.2020.
//  Copyright © 2020 Serhii Semenov. All rights reserved.
//

import SwiftUI

struct EmojiMemoryView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        
        VStack {
            Text(viewModel.gameContent.themeName)
                .padding()
            
            HStack {
                Grid(viewModel.gameContent.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                }
            }
            .padding()
        }
    }
}

struct CardView: View {
    
    var card: MemoryGame<CardContent>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(self.card.content.emoji)
            } else {
                
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: 10.0).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
        .padding(5)
        .foregroundColor(card.content.color)
    }
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmojiMemoryView(viewModel: EmojiMemoryGameViewModel())
            EmojiMemoryView(viewModel: EmojiMemoryGameViewModel())
        }
    }
}
