//
//  NetworkController.swift
//  CryptoVoiceApp
//
//  Created by Muhammet Yiğit on 13.03.2025.
//

import Foundation

class NetworkController {
    
    func fetchCryptoData(url: URL ,completion: @escaping (CryptoModel?) -> Void) {
        let cryptoSession = URLSession(configuration: .default)
        let cryptoTask = cryptoSession.dataTask(with: url) { data, reponse, error in
            if let data = data {
                let cryptoModel = self.jsonDecoder(with: data)
                completion(cryptoModel)
            } else {
                return completion(nil)
            }
        }
        cryptoTask.resume()
    }
    
    func jsonDecoder(with data: Data) -> CryptoModel? {
        let jsonDecoder = JSONDecoder()
        if let decodedData = try? jsonDecoder.decode(CryptoModel.self, from: data) {
            let name = decodedData.cryptoName
            let currency = decodedData.currency
            let time = decodedData.time
            let cryptocurrencyValue = decodedData.cryptocurrencyValue
            let cryptoModel = CryptoModel(cryptoName: name, currency: currency, time: time, cryptocurrencyValue: cryptocurrencyValue)
            return cryptoModel
        }
        return nil
    }
}
