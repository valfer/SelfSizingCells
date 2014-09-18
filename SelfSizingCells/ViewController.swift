//
//  ViewController.swift
//  SelfSizingCells
//
//  Created by Valerio Ferrucci on 18/09/14.
//  Copyright (c) 2014 Valerio Ferrucci. All rights reserved.
//

import UIKit

let kPhotoCellIdentifier = "photoCell"

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var photos : [Photo]!
    
    let iOS8 = floor(NSFoundationVersionNumber) > floor(NSFoundationVersionNumber_iOS_7_1)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let (result, error) = Parser().parse()
        
        if error == nil {
            
            photos = result
        }
        
        if iOS8 {
            
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 102
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)

    }

    func preferredFontChanged(notif : NSNotification) {
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : PhotoCell = tableView.dequeueReusableCellWithIdentifier(kPhotoCellIdentifier, forIndexPath: indexPath) as PhotoCell
        
        let photo = photos[indexPath.row]
        cell.titoloLabel.text = photo.titolo
        cell.titoloLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.descrLabel.text = photo.descr
        cell.descrLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
    }
}

