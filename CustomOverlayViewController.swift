//
//  CustomOverlayViewController.swift
//  SandstoneQuiz
//
//  Created by Rahul Murthy on 3/23/17.
//  Copyright © 2017 Rahul Murthy. All rights reserved.
//

import UIKit


class CustomOverlayViewController: UIViewController {

    @IBOutlet weak var OverlayImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load the overlay image when taking a photo
        OverlayImageView.image = UIImage(named: "topOfDevice")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
