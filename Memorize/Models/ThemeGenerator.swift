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
		Theme(name: "Vehicles", emojis: ["🚂", "🚀", "🚁", "🚜", "🚗", "🛵", "🛻", "🚔","🚀"], numberOfPairsOfCardsToShow: 120, color: "red"),
		Theme(name: "Faces", emojis: ["😃","😂","😍","🙃","😇","😎","🤓","🤓","🤓","🤩","🤬","🥶","🤢","🤠","😷","🤕","😱","😜","🥵","🤡","💩","🥳"], numberOfPairsOfCardsToShow: 6, color: "yellow"),
		Theme(name: "Animals", emojis: ["🐶","🐯","🐱","🐭","🦊","🐻","🐼","🐷","🐨","🐵","🦁", "🐔"], numberOfPairsOfCardsToShow: 12, color: "orange"),
		Theme(name: "Sports", emojis: ["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱", "🏉", "🏓", "🥎", "🥇", "🏆"], numberOfPairsOfCardsToShow: 14, color: "blue"),
		Theme(name: "Suites", emojis: ["♠️","♣️","♥️","♦️"], numberOfPairsOfCardsToShow: 4, color: "black"),
		Theme(name: "Food", emojis: ["🍏","🍎","🍊","🍋","🍌","🥑","🥝","🍇","🍐","🍓","🍒","🍉"], numberOfPairsOfCardsToShow: 8, color: "green")
	]
	
	init() {
		if let randomTheme = ThemeGenerator.themes.randomElement() {
			self.theme = randomTheme
		} else {
			// Default theme
			self.theme = Theme(name: "Vehicles", emojis: ["🚂", "🚀", "🚁", "🚜", "🚗", "🛵", "🛻", "🚔","🚀"], numberOfPairsOfCardsToShow: 120, color: "red")
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
		
		var correctNumberOfCardsToShow: Int {
			if numberOfPairsOfCardsToShow > emojis.count {
				return emojis.count
			}
			return numberOfPairsOfCardsToShow
		}
	}
}
