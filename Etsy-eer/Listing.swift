//
//  Listing.swift
//  Etsy-eer
//
//  Created by Callum Davies on 2017-06-12.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

import UIKit

class Listing: NSObject {

    var listingTitle: String?
    var listingPrice: String?
    var listingCurrencyCode: String?
    var listingImageURL: URL?
    var listingImage: UIImage?
    
    init(title : String, price : String, currencyCode: String, imageURL: URL) {
        self.listingTitle = title
        self.listingPrice = price
        self.listingCurrencyCode = currencyCode
        self.listingImageURL = imageURL
    }
    
}
