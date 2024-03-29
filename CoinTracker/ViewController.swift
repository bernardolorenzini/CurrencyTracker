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
    @IBOutlet weak var lastUpdated: UILabel!

    let urlString = "https://api.coingecko.com/api/v3/exchange_rates"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
        
        let timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    }
    
    @objc func refreshData() -> Void
    {
        fetchData()
    }
    
    func fetchData()
    {
        let url = URL(string: urlString)
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: url!) 
        {
            (data: Data?, response: URLResponse?, error: Error?) in
            
        
            if (error != nil){
                print (error!)
                return
            }
            
            do
            {
                let json = try JSONDecoder().decode(Rates.self, from: data!)
                self.setPrices(currency: json.rates)
            }
            catch
            {
                print (error)
                return
            }
            
            
        }
        
        dataTask.resume()
        
    }
    
    func setPrices(currency: Currency)
    {
        DispatchQueue.main.async {
            
            
            self.btcPrice.text = self.formatPrices(currency.btc)
            self.euroPrice.text = self.formatPrices(currency.eur)
            self.poundPrice.text = self.formatPrices(currency.gbp)
            self.realPrice.text = self.formatPrices(currency.brl)
            
            self.lastUpdated.text = self.formatDate(date: Date())
        }
    }
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM y HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func formatPrices(_ price: Price) -> String
    {
        return String(format: "%@ %.4f", price.unit, price.value)
    }
    
    struct Rates: Codable
    {
        let rates: Currency
    }
    
    struct Currency: Codable
    {
        let btc: Price
        let eur: Price
        let gbp: Price
        let brl: Price
    }
    
    struct Price: Codable
    {
        let name: String
        let unit: String
        let value: Float
        let type: String
//
        
    }


}

