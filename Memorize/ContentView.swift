//
//  ContentView.swift
//  Memorize
//
//  Created by Bobby Nicoloulias on 11/30/21.
//

import SwiftUI

struct ContentView: View {
	@State var emojis = ["🚂", "🚀", "🚁", "🚜", "🚗", "🛵", "🛻", "🚔"].shuffled()
	
	var body: some View {
		VStack {
			Text("Memorize!").font(.largeTitle)
			ScrollView {
				LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
					ForEach(emojis[0..<emojis.count], id: \.self) { emoji in
						CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
					}
				}
				.foregroundColor(.red)
			}
			Spacer()
			HStack {
				Spacer()
				ThemeButton(buttonImage: "car", theme: "Vehicles") {
					self.emojis = ["🚂", "🚀", "🚁", "🚜", "🚗", "🛵", "🛻", "🚔"].shuffled()
				}
				Spacer()
				ThemeButton(buttonImage: "sportscourt", theme: "Sports") {
					self.emojis = ["⚽️","🏀","🏈","⚾️","🎱","🥊","🥏","🛹","🥌"].shuffled()
				}
				Spacer()
				ThemeButton(buttonImage: "face.smiling", theme: "Faces") {
					self.emojis = ["😀","🤣","😉","😚","🧐","😒","😡","🥵","🥳"].shuffled()
				}
				Spacer()
			}
		}
		.padding(.horizontal)
	}
}

struct ThemeButton: View {
	let buttonImage: String
	let theme: String
	let action: () -> (Void)
	
	var body: some View {
		Button {
			action()
		} label: {
			VStack {
				Image(systemName: buttonImage).font(.largeTitle)
				Text(theme).font(.caption)
			}
		}
	}
}

struct CardView: View {
	var content: String
	@State var isFaceUp: Bool = true
	
	var body: some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: 20)
			if isFaceUp {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: 3)
				Text(content).font(.largeTitle)
			} else {
				shape.fill()
			}
		}
		.onTapGesture {
			isFaceUp.toggle()
		}
	}
}















struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.preferredColorScheme(.dark)
		ContentView()
			.preferredColorScheme(.light)
	}
}
