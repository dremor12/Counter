//
//  ViewController.swift
//  Counter
//
//  Created by Дмитрий on 05.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var counter: Int = 0

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var pluseButton: UIButton!
    @IBOutlet weak var historyTextView: UITextView!
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        counterLabel.text = "Значение счётчика: \(counter)"
        historyTextView.text = "История изменений:\n"
        pluseButton.tintColor = .red
    }

    @IBAction func incrementCounter(_ sender: Any) {
        counter += 1
        updateCounterLabel()
        addToHistory(change: "значение изменено на +1")
    }
    
    @IBAction func decrementCounter(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            updateCounterLabel()
            addToHistory(change: "значение изменено на -1")
        } else {
            addToHistory(change: "попытка уменьшить значение счётчика ниже 0")
        }
    }
    
    @IBAction func resetCounter(_ sender: Any) {
        counter = 0
        updateCounterLabel()
        addToHistory(change: "значение сброшено")
    }

    func updateCounterLabel() {
        counterLabel.text = "Значение счётчика: \(counter)"
        }

    func addToHistory(change: String) {
        let currentDate = dateFormatter.string(from: Date())
        let historyEntry = "[\(currentDate)]: \(change)\n"
        historyTextView.text += historyEntry
    }
}

