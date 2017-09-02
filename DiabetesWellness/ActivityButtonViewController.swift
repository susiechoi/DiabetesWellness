//
//  ActivityButtonViewController.swift
//  DiabetesWellness
//
//  Created by Ellie Wood on 7/11/17.
//  Copyright © 2017 dataplustwelve. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ActivityButtonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    var userID : String = (Auth.auth().currentUser?.uid)!
    
    var ref: DatabaseReference!
    var timeStamp: String{
        let currentDateTime=Date()
        let formatter=DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short
        let stamp = formatter.string(from: currentDateTime)
        return stamp
    }
    
    
    @IBOutlet weak var AerobicButton: UIButton!
    @IBOutlet weak var StrengthButton: UIButton!
    @IBOutlet weak var NapButton: UIButton!
    
    func enableButton() {
        AerobicButton.isEnabled = true
        StrengthButton.isEnabled=true
        NapButton.isEnabled=true
    }

    @IBAction func AerobicButton(_ sender: UIButton) {
        ref = Database.database().reference()
    self.ref.child("User").child(userID).child("Activity").child("Aerobic").child("Times").childByAutoId().setValue(timeStamp)
        
        AerobicButton.isEnabled = false
        Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(ActivityButtonViewController.enableButton), userInfo: nil, repeats: false)
    }
    
    @IBAction func StrengthButton(_ sender: UIButton) {
        ref = Database.database().reference()
        self.ref.child("User").child(userID).child("Activity").child("Strength").child("Times").childByAutoId().setValue(timeStamp)
        StrengthButton.isEnabled = false
        Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(ActivityButtonViewController.enableButton), userInfo: nil, repeats: false)
    

    }
    
    @IBAction func NapButton(_ sender: UIButton) {
        ref = Database.database().reference()
        self.ref.child("User").child(userID).child("Activity").child("Nap").child("Times").childByAutoId().setValue(timeStamp)
        
        NapButton.isEnabled = false
        Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(ActivityButtonViewController.enableButton), userInfo: nil, repeats: false)
        

    }
    
    
    

}
