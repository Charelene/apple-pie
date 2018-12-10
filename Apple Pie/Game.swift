//
//  Game.swift
//  Apple Pie
//
//  Created by Андрей on 12/7/18.
//  Copyright © 2018 Andrii Korablin. All rights reserved.
//

import Foundation
struct Game {
    var word: String
    var incorrectMovesLeft: Int
    var guessedLetters: [Character]
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            }   else {
                guessedWord += "_ "
            }
        }
        return guessedWord
    }
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesLeft -= 1
        }
    }

}
