//
//  ContentView.swift
//  Memorize
//
//  Created by Bobby Nicoloulias on 11/30/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
	@ObservedObject var game: EmojiMemoryGame
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
				ForEach(game.cards) { card in
					CardView(card: card)
						.aspectRatio(2/3, contentMode: .fit)
						.onTapGesture {
							game.chooseCard(card)
						}
				}
			}
		}
		.foregroundColor(.red)
		.padding(.horizontal)
	}
}

struct CardView: View {
	let card: EmojiMemoryGame.Card
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
				if card.isFaceUp {
					shape.fill().foregroundColor(.white)
					shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
					Text(card.content).font(font(in: geometry.size))
				} else if card.isMatched {
					shape.opacity(DrawingConstants.zeroOpacity)
				} else {
					shape.fill()
				}
			}
		}
	}
	
	private func font(in size: CGSize) -> Font {
		Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
	}
	
	private struct DrawingConstants {
		static let cornerRadius: CGFloat = 20
		static let lineWidth: CGFloat = 3
		static let fontScale: CGFloat = 0.8
		static let zeroOpacity: Double = 0
	}
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
	static var previews: some View {
		let game = EmojiMemoryGame()
		EmojiMemoryGameView(game: game)
			.preferredColorScheme(.dark)
		EmojiMemoryGameView(game: game)
			.preferredColorScheme(.light)
	}
}
