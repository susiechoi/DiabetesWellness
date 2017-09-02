//
//  WeightTabViewController.swift
//  DiabetesWellness
//
//  Created by Ellie Wood on 7/11/17.
//  Copyright © 2017 dataplustwelve. All rights reserved.
//

import UIKit

class WeightTabViewController: UIViewController {

    @IBOutlet weak var TabView: UIWebView!
    override func viewDidLoad() {
        let Taburl=URL(string: "https://public.tableau.com/shared/4XBMTFYC4?:display_count=yes")
        let request=URLRequest(url: Taburl! as URL)
        TabView.loadRequest(request as URLRequest)
        super.viewDidLoad()
    }
    
    @IBAction func Safari(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://public.tableau.com/shared/4XBMTFYC4?:display_count=yes")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
