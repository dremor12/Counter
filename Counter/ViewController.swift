//
//  ViewController.swift
//  Counter
//
//  Created by Дмитрий on 05.10.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var pluseButton: UIButton!
    @IBOutlet private weak var historyTextView: UITextView!

    private var counter: Int = 0 {
        didSet {
            UserDefaults.standard.set(counter, forKey: "counterValue")
        }
    }
    
    private var history: [String] = [] {
        didSet {
            UserDefaults.standard.set(history, forKey: "historyLog")
        }
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedCounter = UserDefaults.standard.value(forKey: "counterValue") as? Int {
            counter = savedCounter
        }
        
        if let savedHistory = UserDefaults.standard.stringArray(forKey: "historyLog") {
            history = savedHistory
            historyTextView.text = "История изменений:\n" + history.joined(separator: "\n")
        } else {
            historyTextView.text = "История изменений:\n"
        }

        counterLabel.text = "Значение счётчика: \(counter)"
        pluseButton.tintColor = .red
    }
    
    @IBAction private func incrementCounter(_ sender: Any) {
        counter += 1
        updateCounterLabel()
        addToHistory(change: "значение изменено на +1")
    }
    
    @IBAction private func decrementCounter(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            updateCounterLabel()
            addToHistory(change: "значение изменено на -1")
        } else {
            addToHistory(change: "попытка уменьшить значение счётчика ниже 0")
        }
    }
    
    @IBAction private func resetCounter(_ sender: Any) {
        counter = 0
        updateCounterLabel()
        addToHistory(change: "значение сброшено")
    }

    private func updateCounterLabel() {
        counterLabel.text = "Значение счётчика: \(counter)"
    }
    
    private func addToHistory(change: String) {
        let currentDate = dateFormatter.string(from: Date())
        let historyEntry = "[\(currentDate)]: \(change)\n"

        history.append(historyEntry)

        historyTextView.text = "История изменений:\n" + history.joined(separator: "\n")
        
        let bottom = NSRange(location: historyTextView.text.count - 1, length: 1)
        historyTextView.scrollRangeToVisible(bottom)
    }
}
