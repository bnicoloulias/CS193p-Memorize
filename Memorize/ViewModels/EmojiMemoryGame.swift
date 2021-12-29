//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bobby Nicoloulias on 12/22/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
	
	static func createMemoryGame(with theme: ThemeGenerator.Theme) -> MemoryGame<String> {
		MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCardsToShow) { pairIndex in
			theme.emojis[pairIndex]
		}
	}
	
	@Published private var model: MemoryGame<String>
	
	private var theme: ThemeGenerator.Theme
	
	init() {
		//self.theme = ThemeGenerator(explicitNumberOfPairsOfCards: 10).theme
		self.theme = ThemeGenerator().theme
		self.model = EmojiMemoryGame.createMemoryGame(with: theme)
	}
	
	// MARK: - Timer
	var timer = Timer()
	@Published var secondsElapsed = 0.0
	private var timerState: TimerState = .stoped
	
	private enum TimerState {
		case running
		case stoped
	}
	
	private func startTimer() {
		if timerState == .stoped {
			timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
				self.secondsElapsed += 0.1
			}
			timerState = .running
		}
	}
	
	private func endTimer() {
		timer.invalidate()
		timerState = .stoped
		self.secondsElapsed = 0
	}
	
	// MARK: - Start a new game
	
	func newGame() {
		//self.theme = ThemeGenerator(explicitNumberOfPairsOfCards: 10).theme
		self.theme = ThemeGenerator().theme
		self.model = EmojiMemoryGame.createMemoryGame(with: theme)
		self.endTimer()
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
		model.choose(card) {
			startTimer()
		} endTimer: {
			let seconds = secondsElapsed
			endTimer()
			return seconds
		}
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
			case "purple": return .purple
			default: return .red
		}
	}
	
	var cardGradient: LinearGradient {
		let startPoint = UnitPoint.bottomLeading
		let endPoint = UnitPoint.topTrailing
		var colors: [Color] = []
		
		switch theme.color {
			case "blue": colors = [.blue, .green]
			case "yellow": colors = [.yellow, .gray]
			case "red": colors = [.red, .gray]
			case "green": colors = [.green, .purple]
			case "orange": colors = [.orange, .gray]
			case "black": colors = [.gray, .red]
			case "purple": colors = [.purple, .yellow]
			default: colors = [.blue, .green]
		}
		
		return LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint)
	}
	
}
