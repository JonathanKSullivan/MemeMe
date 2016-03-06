//
//  SentMemesCollectionViewController.swift
//  Meme Me
//
//  Created by Jonathan K Sullivan  on 1/27/16.
//  Copyright © 2016 Jonathan K Sullivan . All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController
{

    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.editing = false
        self.collectionView!.reloadData() // Reload Data so if a delete was done to get the new data.
        self.navigationController?.toolbarHidden = true
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! collectionCellViewController
        cell.memeImage.image = memes[indexPath.item].memedImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //Grab an instance of the DetailViewController from the storyboard
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        //Populate view controller with data according to the selected cell
        detailController.meme = self.memes[indexPath.row]
        
        //Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}