//
//  SentMemesTabViewController.swift
//  Meme Me
//
//  Created by Jonathan K Sullivan  on 1/28/16.
//  Copyright © 2016 Jonathan K Sullivan . All rights reserved.
//

import Foundation
import UIKit

class SentMemesTabViewController: UITabBarController{
    override func viewDidLoad() {
        self.tabBar.items?.first?.title = "ListView"
        self.tabBar.items?.last?.title = "CollectionView"
        
    }
}