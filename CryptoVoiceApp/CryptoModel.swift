//
//  CryptoModel.swift
//  CryptoVoiceApp
//
//  Created by Muhammet Yiğit on 13.03.2025.
//

import Foundation

struct CryptoModel: Decodable {
    let cryptoName: String
    let currency: String
    let time: String
    let cryptocurrencyValue: Double
    
    var calculatedValue: String {
        return String(format: "%.3f", cryptocurrencyValue)
    }
    
    enum CodingKeys: String, CodingKey {
        case cryptoName = "asset_id_base"
        case currency = "asset_id_quote"
        case time = "time"
        case cryptocurrencyValue = "rate"
    }
}
