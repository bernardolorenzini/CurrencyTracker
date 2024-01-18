//
//  ViewController.swift
//  CoinTracker
//
//  Created by Bernardo Lorenzini on 17/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var euroPrice: UILabel!
    @IBOutlet weak var btcPrice: UILabel!
    
    @IBOutlet weak var poundPrice: UILabel!
    
    @IBOutlet weak var realPrice: UILabel!
    @IBOutlet weak var lastUpdatedPrice: UILabel!
    
    let urlString = "http://api.coingecko.com/api/v3/exchange_rates"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

