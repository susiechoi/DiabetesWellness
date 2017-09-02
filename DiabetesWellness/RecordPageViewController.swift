//
//  RecordPageViewController.swift
//  DiabetesWellness
//
//  Created by Ellie Wood on 7/11/17.
//  Copyright © 2017 dataplustwelve. All rights reserved.
//

import UIKit

class RecordPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segueToFood(_ sender: Any) {
        performSegue(withIdentifier: "foodSegue", sender: self)
    }
    
    // allow segue from FoodVC back to this VC
    @IBAction func backToOptions(segue: UIStoryboardSegue){
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
