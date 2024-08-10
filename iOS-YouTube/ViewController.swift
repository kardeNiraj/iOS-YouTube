//
//  ViewController.swift
//  iOS-YouTube
//
//  Created by apple on 09/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    let model = Models()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.getVideos()
    }


}

