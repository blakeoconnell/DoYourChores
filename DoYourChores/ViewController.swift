//
//  ViewController.swift
//  DoYourChores
//
//  Created by Blake O'Connell on 10/31/17.
//  Copyright © 2017 Blake O'Connell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var authorLabe: UILabel!
    var quoteTexts = String()
    var authorText = ""
    
    var newsItems:NSMutableArray?
    
    var choresSession: choreSession = choreSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
        quoteLabel.text = quoteTexts
        authorLabe.text = authorText
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPrev"
        {
            let des = segue.destination as! PrevSessionsViewController
            des.choresSession = choresSession
        }
    }
    
    func getNews() {
        
        let urlAsString = "http://quotes.rest/qod.json"
        
        let url = URL(string: urlAsString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!)
            } else {
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        //print(jsonResult)
                        let contents = jsonResult["contents"] as! NSDictionary
                        let quotes = contents["quotes"] as! NSMutableArray
                        
                        let quote = quotes[0] as! NSDictionary
                        
                        let quoteText = (quote["quote"])!
                        
                        let author = (quote["author"])!
                        
                        print(author)
                        
                        print(quoteText)
                        
                        self.authorText = (author as! String)
                        
                        self.quoteTexts = (quoteText as! String)
                        
                        self.quoteLabel.text = quoteText as? String
                        
                        self.authorLabe.text = author as? String
                        
                        //print(contents)
                        
                    } catch {
                        print("Json processing failed")
                    }
                }
            }
        }
        task.resume()
        
    }

    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }


}

