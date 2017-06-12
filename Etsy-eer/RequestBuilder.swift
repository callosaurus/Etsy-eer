//
//  RequestBuilder.swift
//  Etsy-eer
//
//  Created by Callum Davies on 2017-06-12.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

import UIKit

class RequestBuilder: NSObject {

    let apiKeyString = "h0k9dbc9nfb3vm587fcha0gt"
    
    func buildEtsyURLString(limit : Int) -> String {
        
        let urlString = "https://openapi.etsy.com/v2/listings/active?api_key=\(apiKeyString)&limit=\(limit)&fields=listing_id,title,price,currency_code&includes=MainImage(url_75x75)"
        
        return urlString
    }
    
    func buildFixerioURLString() -> String {
        
        let urlString = "http://api.fixer.io/latest?base=USD&symbols=USD,GBP,CAD,EUR"
        
        return urlString
    }
    
}
