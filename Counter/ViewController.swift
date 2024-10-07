//
//  ViewController.swift
//  Counter
//
//  Created by Дмитрий on 05.10.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private var counter: Int = 0
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var pluseButton: UIButton!
    @IBOutlet private weak var historyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = "Значение счётчика: \(counter)"
        historyTextView.text = "История изменений:\n"
        pluseButton.tintColor = .red
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    private func updateCounterLabel() {
        counterLabel.text = "Значение счётчика: \(counter)"
    }
    
    private func addToHistory(change: String) {
        let currentDate = dateFormatter.string(from: Date())
        let historyEntry = "[\(currentDate)]: \(change)\n"
        historyTextView.text += historyEntry
        
        let bottom = NSRange(location: historyTextView.text.count - 1, length: 1)
        historyTextView.scrollRangeToVisible(bottom)
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
}

