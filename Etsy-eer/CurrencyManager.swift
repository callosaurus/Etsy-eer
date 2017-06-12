//
//  CurrencyManager.swift
//  Etsy-eer
//
//  Created by Callum Davies on 2017-06-12.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

import UIKit

class CurrencyManager: NSObject {

    var exchangeRates = ["USD":1.00,
                         "CAD": 1.3615,
                         "GBP": 0.7713,
                         "EUR": 0.89952]
    
    
    func convert(price : String, fromThisCurrency : String, toCurrency : String) -> String {
        
        let exchangeFactor = (exchangeRates[fromThisCurrency])! / (exchangeRates[toCurrency])!
        var inputPrice = price
        inputPrice.remove(at: price.startIndex)
        
        let newPrice = (Double(inputPrice))! / exchangeFactor
        var currCode = ""
        
        switch toCurrency {
        case "USD":
            currCode = "$"
        case "CAD":
            currCode = "$"
        case "GBP":
            currCode = "£"
        case "EUR":
            currCode = "€"
        default:
            currCode = ""
        }
        
        return String(format: "%@%.2f", currCode, newPrice)
    }
    
}
