//
//  ViewController.swift
//  CryptoVoiceApp
//
//  Created by Muhammet Yiğit on 13.03.2025.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var cyrptoNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var textFieldLabel: UITextField!

    // MARK: - Properties
    let networkController = NetworkController()
    let synthesizer = AVSpeechSynthesizer()
    var text: String {
        if let name = cyrptoNameLabel.text, let value = valueLabel.text, let currency = currencyLabel.text {
            return "\(name) anlık olarak değeri \(value) \(currency)'dır"
        } else {
            return ""
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "tr-TR") // for English
        synthesizer.speak(utterance)
    }
    
    func getAPIKey() -> String? {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            return dict["API_KEY"] as? String
        }
        return nil
    }
    
    // MARK: - Actions
    @IBAction func tellMeCyrpto(_ sender: UIButton) {
        speakText(text)
    }
    @IBAction func searchButton(_ sender: UIButton) {
        
        guard let apiKey = getAPIKey() else { return }
        
        if let cryptoName = textFieldLabel.text, let url = URL(string: "https://api-realtime.exrates.coinapi.io/v1/exchangerate/\(cryptoName)/USD?apikey=\(apiKey)") {
            networkController.fetchCryptoData(url: url) { cyrptoData in
                DispatchQueue.main.async {
                    if let cyrptoData = cyrptoData {
                        self.cyrptoNameLabel.text = cyrptoData.cryptoName
                        self.valueLabel.text = cyrptoData.calculatedValue
                        self.currencyLabel.text = cyrptoData.currency
                    }
                }
            }
            
        }
    }
}
