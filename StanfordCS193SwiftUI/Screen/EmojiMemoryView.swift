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
            HStack {
                Text(viewModel.gameContent.themeName)
                    .padding()
                
                Text("\(viewModel.gameContent.points)")
                    .padding()
            }
            
            HStack {
                Grid(viewModel.gameContent.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
                }
            }
            .padding()
            
            Button("Start new Game") {
                viewModel.createNewGame()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)
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
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle(degrees: 110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(self.card.content.emoji)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .font(Font.system(size: fontSize(for: size)))
            .padding(5)
            .foregroundColor(card.content.color)
        }
    }
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel()
        game.choose(card: game.gameContent.cards[0])
        return EmojiMemoryView(viewModel: game)
    }
}
