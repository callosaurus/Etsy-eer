//
//  NetworkManager.swift
//  Etsy-eer
//
//  Created by Callum Davies on 2017-06-12.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class NetworkManager: NSObject {
  
  var arrayOfListings = [Listing]()
  var exchangeRates = [String : NSNumber]()
  let requestFactory = RequestFactory()
  
  func getEtsyListings (completionHandler: @escaping (Bool) -> Void) {
    let urlString = requestFactory.buildEtsyURLString(limit: 60)
    Alamofire.request(urlString).responseJSON { response in
      
      if response.result.isFailure == true {
        return
      }
      
      let json = JSON(response.result.value!)
      let results:[JSON] = json["results"].arrayValue
      
      for item in results {
        
        guard var listingTitle = item["title"].string else {  // Possibility of "Access denied on association MainImage"
          return
        }
        
        listingTitle = listingTitle.stringByDecodingHTMLEntities  // correctly encodes html entities, e.g. &#39; -> '
        let listingPrice = item["price"].string
        let listingCurrencyCode = item["currency_code"].string
        let listingImageURL = item["MainImage"]["url_75x75"].url
        
        let listing = Listing(title: listingTitle, price: String(format: "$%@", listingPrice!), currencyCode: listingCurrencyCode!, imageURL: listingImageURL!)
        
        Alamofire.request(listingImageURL!).responseImage { response in
          if let image = response.result.value {
            listing.listingImage = image
            completionHandler(true)
          }
        }
        
        self.arrayOfListings.append(listing)
      }
    }
  }
  
  func getCurrentExchangeRates(completionHandler: @escaping (Bool) -> Void) {
    let urlString = requestFactory.buildFixerioURLString()
    
    Alamofire.request(urlString).responseJSON {response in
      if response.result.isFailure == true {
        return
      }
      
      let json = JSON(response.result.value!)
      self.exchangeRates = ["CAD" : json["rates"]["CAD"].numberValue,
                            "GBP" : json["rates"]["GBP"].numberValue,
                            "EUR" : json["rates"]["EUR"].numberValue]
      completionHandler(true)
    }
  }
}
