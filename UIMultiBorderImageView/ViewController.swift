//
//  ViewController.swift
//  UIMultiBorderImageView
//
//  Created by Bassem Qoulta on 1/13/19.
//  Copyright © 2019 Bassem Qoulta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomImageView.apply(borders: [Border(width: 5, color: UIColor.red),
                                        Border(width: 5, color: UIColor.yellow),
                                        Border(width: 5, color: UIColor.green),
                                        Border(width: 5, color: UIColor.blue)])
        
        
        topImageView.layer.cornerRadius = topImageView.frame.size.width/2
        topImageView.clipsToBounds = true
        topImageView.apply(borders: [Border(width: 5, color: UIColor.green),
                            Border(width: 5, color: UIColor.blue)])
    }
}

