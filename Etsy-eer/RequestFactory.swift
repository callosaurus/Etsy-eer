//
//  RequestFactory.swift
//  Etsy-eer
//
//  Created by Callum Davies on 2017-06-12.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

import UIKit

class RequestFactory: NSObject {
  
  let apiKeyString = "h0k9dbc9nfb3vm587fcha0gt"
  let fixerioAccessKey = "9b1e285e2942219ed9227f2da874"
  let limit = 20
  
  func buildEtsyURLString(limit : Int) -> String {
    return "https://openapi.etsy.com/v2/listings/active?api_key=\(apiKeyString)&limit=\(limit)&fields=listing_id,title,price,currency_code&includes=MainImage(url_75x75)"
  }
  
  func buildFixerioURLString() -> String {
    return "http://data.fixer.io/api/latest?access_key=\(fixerioAccessKey)&symbols=USD,GBP,CAD,EUR"
  }
}
