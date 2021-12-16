//
//  DetailsViewController.swift
//  Final Steps
//
//  Created by admin on 16/12/2021.
//

import UIKit

class DetailsViewController: UIViewController {

    var label1t :String?
    var label2t :String?
    var label3t :String?
    var label4t :String?
    
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label1.text = label1t
        label2.text = label2t
        label3.text = label3t
        label4.text = label4t
        
    }

}
