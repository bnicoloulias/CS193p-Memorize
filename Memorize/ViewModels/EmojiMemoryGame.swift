//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bobby Nicoloulias on 12/22/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
	
	static func createMemoryGame(with theme: ThemeGenerator.Theme) -> MemoryGame<String> {
		MemoryGame<String>(numberOfPairsOfCards: theme.correctNumberOfCardsToShow) { pairIndex in
			theme.emojis[pairIndex]
		}
	}
	
	@Published private var model: MemoryGame<String>
	
	private var theme: ThemeGenerator.Theme
	
	init() {
		self.theme = ThemeGenerator().theme
		self.model = EmojiMemoryGame.createMemoryGame(with: theme)
	}
	
	// MARK: - Start a new game
	
	func newGame() {
		self.theme = ThemeGenerator().theme
		self.model = EmojiMemoryGame.createMemoryGame(with: theme)
	}
	
	// MARK: - MemoryGame
	
	var cards: Array<MemoryGame<String>.Card> {
		model.cards
	}
	
	var score: Int {
		model.score
	}
	
	// MARK: Intent(s)
	
	func chooseCard(_ card: MemoryGame<String>.Card) {
		model.choose(card)
	}
	
	
	// MARK: - Theme
	
	var themeName: String {
		theme.name
	}
	
	var cardColor: Color {
		switch theme.color {
			case "blue": return .blue
			case "yellow": return .yellow
			case "red": return .red
			case "green": return .green
			case "orange": return .orange
			case "black": return .black
			case "purple": return .purple
			default: return .red
		}
	}
	
}
