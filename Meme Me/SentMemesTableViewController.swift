//
//  SentMemesTableViewController.swift
//  Meme Me
//
//  Created by Jonathan K Sullivan  on 1/28/16.
//  Copyright © 2016 Jonathan K Sullivan . All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.editing = false
        self.tableView.reloadData() // Reload Data so if a delete was done to get the new data.
        self.navigationController?.toolbarHidden = true
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // TODO: Implement this method to get the correct row count
        return self.memes.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // TODO: Implement method
        // 1. Dequeue a reusable cell from the table, using the correct “reuse identifier”
        // 2. Find the model object that corresponds to that row
        // 3. Set the images and labels in the cell with the data from the model object
        // 4. return the cell.
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomMemeRow") as! tableCellViewController
        cell.memeImage.image = self.memes[indexPath.row].memedImage
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Grab an instance of the DetailViewController from the storyboard
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        //Populate view controller with data according to the selected cell
        detailController.meme = self.memes[indexPath.row]
        
        //Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}