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
    let requestBuilder = RequestBuilder()
    
    func getEtsyListings (completionHandler: @escaping (Bool) -> Void) {
        
        let urlString = requestBuilder.buildEtsyURLString(limit: 15)
        
        Alamofire.request(urlString).responseJSON { response in
            
            if response.result.isFailure == true {
                //show alert saying could not fetch data
                return
            }
            
            let json = JSON(response.result.value!)
            let results:[JSON] = json["results"].arrayValue
            
            for item in results {
                
                guard var listingTitle = item["title"].string else {
                    //Possibility of "Access denied on association MainImage"
                    return
                }
                
                //correctly encodes html entities, useful for: &#39; -> '
                listingTitle = listingTitle.stringByDecodingHTMLEntities
                
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

    
    
    
}
