//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bobby Nicoloulias on 12/22/21.
//

import Foundation

/*
	When someone uses MemoryGame, they will have to delcare <CardContent> type (String, Image, etc)
 */

struct MemoryGame<CardContent> {
	private(set) var cards: Array<Card>
	
	func choose(_ card: Card) {
		
	}
	
	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		cards = Array<Card>()
		// and numberOfPairsOfCards x 2 cards to cards array
		for pairIndex in 0..<numberOfPairsOfCards {
			let content: CardContent = createCardContent(pairIndex)
			cards.append(Card(content: content))
			cards.append(Card(content: content))
		}
	}
	
	struct Card {
		var isFaceUp: Bool = false
		var isMatched: Bool = false
		var content: CardContent
	}
}
