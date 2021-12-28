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
	private(set) var cards: Array<Card>
	
	private var indexOfTheOneAndOnlyFaceUpCard: Int?
	
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
				indexOfTheOneAndOnlyFaceUpCard = nil
			} else {
				for index in cards.indices {
					cards[index].isFaceUp = false
				}
				indexOfTheOneAndOnlyFaceUpCard = chosenIndex
			}
			cards[chosenIndex].isFaceUp.toggle()
		}
		print("\(cards)")
	}
	
	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		cards = Array<Card>()
		for pairIndex in 0..<numberOfPairsOfCards {
			let content: CardContent = createCardContent(pairIndex)
			cards.append(Card(content: content, id: pairIndex*2))
			cards.append(Card(content: content, id: pairIndex*2+1))
		}
	}
	
	struct Card: Identifiable {
		var isFaceUp: Bool = false
		var isMatched: Bool = false
		var content: CardContent
		var id: Int
	}
}
