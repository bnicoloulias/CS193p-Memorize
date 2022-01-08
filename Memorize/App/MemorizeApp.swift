//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Bobby Nicoloulias on 11/30/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
	// Using let b/c classes are mutable
	private let game = EmojiMemoryGame()
	
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
