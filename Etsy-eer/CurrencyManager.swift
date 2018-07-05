//
//  CurrencyManager.swift
//  Etsy-eer
//
//  Created by Callum Davies on 2017-06-12.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

import UIKit

class CurrencyManager: NSObject {
  
  var exchangeRates = ["USD": 1.166183,
                       "GBP": 0.881926,
                       "CAD": 1.533076,
                       "EUR": 1.000000]
  
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
