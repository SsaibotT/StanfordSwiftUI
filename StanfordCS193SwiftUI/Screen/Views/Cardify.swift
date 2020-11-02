//
//  Cardify.swift
//  StanfordCS193SwiftUI
//
//  Created by Serhii Semenov on 02.11.2020.
//  Copyright © 2020 Serhii Semenov. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                content
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
    
}

extension View {
    
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
