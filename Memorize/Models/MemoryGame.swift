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

struct MemoryGame<CardContent> where CardContent: Equatable {
	// VM can get (view) cards, but not set
	private(set) var cards: Array<Card>
	
	private var indexOfTheOneAndOnlyFaceUpCard: Int? {
		get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
		set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
		// newValue is the value someone set indexOfTheOneAndOnlyFaceUpCard to
	}
	
	mutating func choose(_ card: Card) {
		if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
		   !cards[chosenIndex].isFaceUp,
		   !cards[chosenIndex].isMatched
		{
			if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
				if cards[chosenIndex].content == cards[potentialMatchIndex].content {
					cards[chosenIndex].isMatched = true
					cards[potentialMatchIndex].isMatched = true
				}
				cards[chosenIndex].isFaceUp = true
			} else {
				indexOfTheOneAndOnlyFaceUpCard = chosenIndex
			}
		}
	}
	
	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		cards = []
		// add numberOfPairsOfCards x 2 cards to cards array
		for pairIndex in 0..<numberOfPairsOfCards {
			let content: CardContent = createCardContent(pairIndex)
			cards.append(Card(content: content, id: pairIndex*2))
			cards.append(Card(content: content, id: pairIndex*2+1))
		}
	}
	
	struct Card: Identifiable {
		var isFaceUp = false
		var isMatched = false
		let content: CardContent
		let id: Int
	}
}

extension Array {
	var oneAndOnly: Element? {
		if count == 1 {
			return first
		} else {
			return nil
		}
	}
}
