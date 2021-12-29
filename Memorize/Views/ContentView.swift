//
//  ContentView.swift
//  Memorize
//
//  Created by Bobby Nicoloulias on 11/30/21.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var viewModel: EmojiMemoryGame
	
	var body: some View {
			ScrollView {
				HStack {
					Text(viewModel.themeName).font(.largeTitle)
					Spacer()
					Button {
						viewModel.newGame()
					} label: {
						Text("New Game").font(.subheadline)
					}
				}
				LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
					ForEach(viewModel.cards) { card in
						CardView(card: card, cardGradient: viewModel.cardGradient)
							.aspectRatio(2/3, contentMode: .fit)
							.onTapGesture {
								viewModel.chooseCard(card)
							}
					}
				}
				VStack {
					Text("Score: \(viewModel.score)")
						.font(.largeTitle)
					
					Text(String(format: "%.1f", viewModel.secondsElapsed))
				}
			}
			.foregroundColor(viewModel.cardColor)
			.padding(.horizontal)
	}
}

struct CardView: View {
	let card: MemoryGame<String>.Card
	let cardGradient: LinearGradient
	
	var body: some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: 20)
			if card.isFaceUp {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: 3)
				Text(card.content).font(.largeTitle)
			} else if card.isMatched {
				shape.opacity(0)
			} else {
				shape.fill(cardGradient)
			}
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let game = EmojiMemoryGame()
		ContentView(viewModel: game)
			.preferredColorScheme(.dark)
		ContentView(viewModel: game)
			.preferredColorScheme(.light)
	}
}
