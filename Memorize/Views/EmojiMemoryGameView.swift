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
		AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
			if card.isMatched && !card.isFaceUp {
				Rectangle().opacity(0)
			} else {
				CardView(card: card)
					.padding(4)
					.onTapGesture {
						game.chooseCard(card)
					}
			}
		}
		.foregroundColor(.red)
		.padding(.horizontal)
	}
	
	//	@ViewBuilder
	//	private func cardView(for card: EmojiMemoryGame.Card) -> some View {
	//		if card.isMatched && !card.isFaceUp {
	//			Rectangle().opacity(0)
	//		} else {
	//			CardView(card: card)
	//				.padding(4)
	//				.onTapGesture {
	//					game.chooseCard(card)
	//				}
	//		}
	//	}
	
}

struct CardView: View {
	let card: EmojiMemoryGame.Card
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
					.padding(DrawingConstants.circlePadding)
					.opacity(DrawingConstants.circleOpacity)
				Text(card.content)
					.rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
					.animation(
						Animation.linear(duration: DrawingConstants.contentAnimationDuration)
								.repeatForever(autoreverses: false)
					)
					.font(Font.system(size: DrawingConstants.fontSize))
					.scaleEffect(scale(thatFits: geometry.size))
			}
			.cardify(isFaceUp: card.isFaceUp)
		}
	}
	
	private func scale(thatFits size: CGSize) -> CGFloat {
		min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
	}
	
	private struct DrawingConstants {
		static let fontScale: CGFloat = 0.70
		static let fontSize: CGFloat = 32
		static let zeroOpacity: Double = 0
		static let circleOpacity: Double = 0.5
		static let circlePadding: CGFloat = 5
		static let contentAnimationDuration: Double = 1
	}
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
	static var previews: some View {
		let game = EmojiMemoryGame()
		game.chooseCard(game.cards.first!)
		return EmojiMemoryGameView(game: game)
			.preferredColorScheme(.light)
	}
}
