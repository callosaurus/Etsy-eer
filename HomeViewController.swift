//
//  HomeViewController.swift
//  Etsy-eer
//
//  Created by Callum Davies on 2017-06-12.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var previousSegmentIndex : NSInteger?
    var actualSegmentIndex : NSInteger?
    var listingDataSource = [Listing]()
    var currencyManager = CurrencyManager()
    var exchangeRates = [String : NSNumber]()
    lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        
        self.previousSegmentIndex = 0
        self.actualSegmentIndex = 0
        
        self.configureSampleDataSource()
        self.tableView.reloadData()
        Loader.addLoaderTo(self.tableView)
        
        let networkManager = NetworkManager()
        networkManager.getEtsyListings(completionHandler: {(true) in
            
            //removes placeholder elements for loading animation
            self.listingDataSource.removeAll()
            
            while self.listingDataSource.count < 10 {
                for item in networkManager.arrayOfListings {
                    if item.listingCurrencyCode == "USD" {
                        self.listingDataSource.append(item)
                    }
                }
            }
            self.tableView.reloadData()
            self.loaded()
        })
        
        networkManager.getCurrentExchangeRates(completionHandler: {(true) in
            self.exchangeRates = networkManager.exchangeRates
        })
    }
    
    func loaded()
    {
        Loader.removeLoaderFrom(self.tableView)
    }
    
    func refresh(_ sender: UIRefreshControl) {
        let networkManager = NetworkManager()
        networkManager.getEtsyListings(completionHandler: {(true) in
            
            Loader.addLoaderTo(self.tableView)
            
            while self.listingDataSource.count < 10 {
                for item in networkManager.arrayOfListings {
                    if item.listingCurrencyCode == "USD" {
                        
                        self.listingDataSource.append(item)
                    }
                }
            }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            self.loaded()
        })
    }
    
    func prepareTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_ :)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func configureSampleDataSource() {
        
        for _ in 0..<15 {
            let sampleListing = Listing(title: "", price: "", currencyCode: "", imageURL: URL(string: "http://www.sample.com")!)
            //            sampleListing.listingImage = UIImage(named: "sample_picture_image")
            self.listingDataSource.append(sampleListing)
        }
        
    }
    
    @IBAction func currencyControlValueChanged(_ sender: UISegmentedControl) {
        
        self.previousSegmentIndex = self.actualSegmentIndex
        self.actualSegmentIndex = sender.selectedSegmentIndex
        
        for item in listingDataSource {
            let newPrice = self.currencyManager.convert(price: item.listingPrice!, fromThisCurrency: sender.titleForSegment(at: self.previousSegmentIndex!)!, toCurrency: (sender.titleForSegment(at: self.actualSegmentIndex!))!)
            item.listingPrice = "\(newPrice)"
        }
        
        self.tableView.reloadData()
    }
    
    //MARK: Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listingDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listing", for: indexPath) as! EtsyListingCell
        cell.listing = listingDataSource[indexPath.row]
        return cell
    }
    

    

}
