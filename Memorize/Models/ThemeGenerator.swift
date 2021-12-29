//
//  ThemeGenerator.swift
//  Memorize
//
//  Created by Bobby Nicoloulias on 12/28/21.
//

import Foundation

struct ThemeGenerator {
	private(set) var theme: Theme
	
	static let themes: [Theme] = [
		Theme(name: "Vehicles", emojis: ["🚂", "🚀", "🚁", "🚜", "🚗", "🛵", "🛻", "🚔","🚀"], numberOfPairsOfCardsToShow: nil, color: "red"),
		Theme(name: "Faces", emojis: ["😃","😂","😍","🙃","😇","😎","🤓","🤓","🤓","🤩","🤬","🥶","🤢","🤠","😷","🤕","😱","😜","🥵","🤡","💩","🥳"], numberOfPairsOfCardsToShow: 10, color: "yellow"),
		Theme(name: "Animals", emojis: ["🐶","🐯","🐱","🐭","🦊","🐻","🐼","🐷","🐨","🐵","🦁", "🐔"], numberOfPairsOfCardsToShow: 10, color: "orange"),
		Theme(name: "Sports", emojis: ["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱", "🏉", "🏓", "🥎", "🥇", "🏆"], numberOfPairsOfCardsToShow: 12, color: "blue"),
		Theme(name: "Suites", emojis: ["♠️","♣️","♥️","♦️"], numberOfPairsOfCardsToShow: 4, color: "red"),
		Theme(name: "Food", emojis: ["🍏","🍎","🍊","🍋","🍌","🥑","🥝","🍇","🍐","🍓","🍒","🍉"], numberOfPairsOfCardsToShow: nil, color: "green")
	]
	
	init(explicitNumberOfPairsOfCards: Int? = nil) {
		if let randomTheme = ThemeGenerator.themes.randomElement() {
			self.theme = randomTheme
		} else {
			// Default theme
			self.theme = Theme(name: "Vehicles", emojis: ["🚂", "🚀", "🚁", "🚜", "🚗", "🛵", "🛻", "🚔","🚀"], numberOfPairsOfCardsToShow: nil, color: "red")
		}
		
		if let explicitNumberOfPairsOfCards = explicitNumberOfPairsOfCards, explicitNumberOfPairsOfCards < theme.emojis.count {
			self.theme.numberOfPairsOfCardsToShow = explicitNumberOfPairsOfCards
		}
		self.theme.shuffleEmojis()
	}
	
	struct Theme {
		var name: String
		var emojis: [String]
		var numberOfPairsOfCardsToShow: Int
		var color: String
		
		mutating func shuffleEmojis() {
			emojis.shuffle()
		}
		
		init(name: String, emojis: [String], numberOfPairsOfCardsToShow: Int?, color: String) {
			self.name = name
			self.emojis = emojis
			self.color = color
			if let numberOfPairsOfCardsToShow = numberOfPairsOfCardsToShow {
				self.numberOfPairsOfCardsToShow = numberOfPairsOfCardsToShow
			} else {
				self.numberOfPairsOfCardsToShow = Int.random(in: 2..<emojis.count)
			}
			print(self.name)
			print(self.numberOfPairsOfCardsToShow)
		}
	}
}
