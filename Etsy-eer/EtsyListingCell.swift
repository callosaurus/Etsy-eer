//
//  EtsyListingCell.swift
//  Etsy-eer
//
//  Created by Callum Davies on 2017-06-12.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

import UIKit

class EtsyListingCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var listingImageView: UIImageView!
    
    var listing: Listing! {
        didSet {
            configure()
        }
    }
    
    fileprivate func configure() {
        
        listingImageView.image = listing.listingImage
        titleLabel.text = listing.listingTitle
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        priceLabel.text = listing.listingPrice
        priceLabel.textColor = UIColor.orange
    }

}
