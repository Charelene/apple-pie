//
//  ViewController.swift
//  Apple Pie
//
//  Created by Андрей on 12/6/18.
//  Copyright © 2018 Andrii Korablin. All rights reserved.
//

import UIKit
import AVFoundation
var audioPlayer = AVAudioPlayer()
var listOfWords = ["совесть", "таблетка", "датчанин", "красота", "дно", "корабль", "поле", "рис", "ожидание", "пологий", "лукошко", "ответственность", "плезиозавр", "фазан", "тенденция", "партия", "действие", "порядок", "преимущество", "кресло", "сотня", "житель", "товарищ", "польза", "костюм", "средство", "норма", "охрана", "способ", "сентябрь", "чиновник", "столица", "продукт", "журналист", "направление", "реакция", "бюджет", "внимание", "ресторан", "орган", "образование", "поселок", "отрасль", "помощь", "ремонт", "предмет", "судьба", "воспитание"]
let incorrectMovesAllowed = 7
let cast =  ["Vivien", "Marlon", "Kim", "Karl"]
let list = cast.joined(separator: ",")

class ViewController: UIViewController {
    @IBOutlet weak var TreeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    var totalWins = 0 {
        didSet {
            newRound()
            playWinSound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
            playLoseSound()
        }
    }

    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var currentGame: Game!
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Побед: \(totalWins), Поражений: \(totalLosses)"
        TreeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesLeft)")
        }
    @IBAction func buttonTapped (_ sender: UIButton) {
        sender.isEnabled = false
        if let buttonTitle = sender.title(for: .normal) {
            print(buttonTitle)
        }
        sender.setTitleColor(UIColor.darkGray, for: .disabled)
        let letterString = sender.title (for: .normal)!
        let letter = Character (letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
        playClickSound()
    }
    func updateGameState() {
        if currentGame.incorrectMovesLeft == 0 {
            playLoseSound()
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            playWinSound()
            totalWins += 1
        } else {
            updateUI()
        }
    }
    func newRound() {
        let randomIndex = Int(arc4random_uniform(UInt32(listOfWords.count)))
        let newWord = listOfWords[randomIndex]
        if !listOfWords.isEmpty {
            currentGame = Game(word: newWord, incorrectMovesLeft: incorrectMovesAllowed, guessedLetters: [])
            print(newWord)
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    func playClickSound() {
        let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "key_press_click", ofType: "caf")!)
            do {
            audioPlayer = try AVAudioPlayer(contentsOf: alertSound)
            } catch _{
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    func playLoseSound() {
        let loseSound = URL(fileURLWithPath: Bundle.main.path(forResource: "lost", ofType: "caf")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: loseSound)
        } catch _{
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    func playWinSound() {
        let winSound = URL(fileURLWithPath: Bundle.main.path(forResource: "win", ofType: "caf")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: winSound)
        } catch _{
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}
