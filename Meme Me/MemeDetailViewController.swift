//
//  MemeDetailViewController.swift
//  Meme Me
//
//  Created by Jonathan K Sullivan  on 1/28/16.
//  Copyright © 2016 Jonathan K Sullivan . All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController{
    var meme:Meme!
    
    @IBOutlet weak var MemeImage: UIImageView!
    override func viewWillAppear(animated: Bool) {
        MemeImage.image = meme.memedImage
        self.tabBarController?.tabBar.items?.first?.enabled = false
        self.tabBarController?.tabBar.items?.last?.enabled = false
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.items?.first?.enabled = true
        self.tabBarController?.tabBar.items?.last?.enabled = true
    }
    @IBAction func Share(sender: AnyObject) {
        let image: UIImage = MemeImage.image!
        let activityPicker = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(activityPicker, animated: true, completion:nil)
    }
}