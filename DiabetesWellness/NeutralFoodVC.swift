//
//  NeutralFoodVC.swift
//  Food Awareness
//
//  Created by Susie Choi on 6/28/17.
//  Copyright © 2017 Susie Choi. All rights reserved.
//
import UIKit

class NeutralFoodVC: UIViewController {
    
    @IBOutlet weak var neutralFoodView: UITextView!
    var neutralFoodArray = [String]()
    var neutralFoodToShow = ""
    var neutralFoodDefaults = UserDefaults.standard
    
    // retrieve previously-inputed neutral foods in array form
    // append newest food input to array if not already contained within
    // write out to neutralFoodView
    override func viewDidLoad() {
        super.viewDidLoad()
        neutralFoodArray = neutralFoodDefaults.object(forKey: "savedneutralFoodArray") as? [String] ?? [String]()
        if neutralFoodToShow != ""{
            if !neutralFoodArray.contains(neutralFoodToShow){
                neutralFoodArray.append(neutralFoodToShow)
            }
        }
        for neutralFood in neutralFoodArray {
            neutralFoodView.text.append("-\(neutralFood)")
            if neutralFoodArray.index(of: neutralFood) != neutralFoodArray.count-1 {
                neutralFoodView.text.append("\n")
            }
        }
    }
    
    // remove just-added "neutral" food
    // if just viewing, send mistap alert
    @IBAction func undoAdd(_ sender: Any) {
        if neutralFoodToShow != "" {
            neutralFoodArray.remove(at: neutralFoodArray.count-1)
            neutralFoodView.text = ""
            for neutralFood in neutralFoodArray {
                neutralFoodView.text.append("-\(neutralFood)")
                if neutralFoodArray.index(of: neutralFood) != neutralFoodArray.count-1 {
                    neutralFoodView.text.append("\n")
                }
            }
        }
        else {
            mistappedAlert()
        }
    }
    
    // alert if user attempts to "undo add" when no food was added to list
    func mistappedAlert(){
        let alert = UIAlertController(title: "Oops!", message: "No food was added.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Got it.", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    // dismiss keyboard if tapped outside text view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // return to initial view
    @IBAction func backButtonTapped(_ sender: Any) {
        if neutralFoodView.text != "" {
            doneEditing()
        }
        self.performSegue(withIdentifier: "backToMenuFromNeutral", sender: self)
    }
    
    // re-write defaults to incorporate newest food input and/or list edits
    func doneEditing() {
        neutralFoodView.resignFirstResponder()
        neutralFoodArray = neutralFoodView.text.components(separatedBy: "\n-")
        let firstItem = neutralFoodArray[0]
        let firstTruncIndex = firstItem.index(firstItem.startIndex, offsetBy: 1)
        let truncFirstItem = firstItem.substring(from: firstTruncIndex)
        neutralFoodArray[0] = truncFirstItem
        neutralFoodDefaults.set(neutralFoodArray, forKey: "savedneutralFoodArray")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
