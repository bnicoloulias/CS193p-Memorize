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
	private var seenCards: [Card] = []
	private(set) var score: Int = 0
	
	private var indexOfTheOneAndOnlyFaceUpCard: Int?
	
	mutating func choose(_ card: Card, startTimer: () -> Void, endTimer: () -> Double) {
		if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
			!cards[chosenIndex].isFaceUp,
			!cards[chosenIndex].isMatched
		{
			if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
				if cards[chosenIndex].content == cards[potentialMatchIndex].content {
					cards[chosenIndex].isMatched = true
					cards[potentialMatchIndex].isMatched = true
					let secondsElapsed = endTimer()
					let scoreBonus = Int(max(10 - secondsElapsed, 2))
					score += scoreBonus
				} else {
					for card in seenCards {
						if card.id == cards[chosenIndex].id || card.id == cards[potentialMatchIndex].id {
							score -= 1
						}
					}
					seenCards.append(cards[chosenIndex])
					seenCards.append(cards[potentialMatchIndex])
				}
				indexOfTheOneAndOnlyFaceUpCard = nil
			} else {
				for index in cards.indices {
					cards[index].isFaceUp = false
				}
				indexOfTheOneAndOnlyFaceUpCard = chosenIndex
				startTimer()
			}
			cards[chosenIndex].isFaceUp.toggle()
		}
		//print("\(cards)")
		//print(seenCards)
	}
	
	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		cards = Array<Card>()
		for pairIndex in 0..<numberOfPairsOfCards {
			let content: CardContent = createCardContent(pairIndex)
			// Check to see if CardContent has already been used
			if !cards.contains(where: { $0.content == content }) {
				cards.append(Card(content: content, id: pairIndex*2))
				cards.append(Card(content: content, id: pairIndex*2+1))
			} else {
				print("CardContet \(content) already used")
			}
		}
		cards = cards.shuffled()
	}
	
	struct Card: Identifiable {
		var isFaceUp: Bool = false
		var isMatched: Bool = false
		var content: CardContent
		var id: Int
	}
}
