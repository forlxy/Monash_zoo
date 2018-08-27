//
//  ViewController.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/19.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailDetail: UILabel!
    @IBOutlet weak var detailLocation: UILabel!
    @IBOutlet weak var detailPhoto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

