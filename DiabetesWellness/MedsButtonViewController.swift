//
//  MedsButtonViewController.swift
//  DiabetesWellness
//
//  Created by Ellie Wood on 7/11/17.
//  Copyright © 2017 dataplustwelve. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MedsButtonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    var ref: DatabaseReference!
    var timeStamp: String{
        let currentDateTime=Date()
        let formatter=DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short
        let stamp = formatter.string(from: currentDateTime)
        return stamp
    }
    
     var userID : String = (Auth.auth().currentUser?.uid)!
    
    @IBOutlet weak var NormalButton: UIButton!
    @IBOutlet weak var EmergencyButton: UIButton!
    @IBOutlet weak var ForgotButton: UIButton!
    
    func enableButton() {
        NormalButton.isEnabled = true
        EmergencyButton.isEnabled=true
        ForgotButton.isEnabled=true
    }
    

    @IBAction func NormalButton(_ sender: UIButton) {
        ref = Database.database().reference()
        self.ref.child("User").child(userID).child("Meds").child("NormalDose").child("Times").childByAutoId().setValue(timeStamp)
        
        NormalButton.isEnabled = false
        Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(MedsButtonViewController.enableButton), userInfo: nil, repeats: false)
    
    }
    
    @IBAction func EmergencyButton(_ sender: UIButton) {
        ref = Database.database().reference()
        self.ref.child("User").child(userID).child("Meds").child("EmergencyDose").child("Times").childByAutoId().setValue(timeStamp)
        
        EmergencyButton.isEnabled = false
        Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(MedsButtonViewController.enableButton), userInfo: nil, repeats: false)
    }
    
    @IBAction func ForgotButton(_ sender: UIButton) {
        ref = Database.database().reference()
        self.ref.child("User").child(userID).child("Meds").child("ForgotYesterDose").child("Times").childByAutoId().setValue(timeStamp)
        
       ForgotButton.isEnabled = false
        Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(MedsButtonViewController.enableButton), userInfo: nil, repeats: false)
     
    }


}
