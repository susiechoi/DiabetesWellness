//
//  BadFoodVC.swift
//  Food Awareness
//
//  Created by Susie Choi on 6/28/17.
//  Copyright © 2017 Susie Choi. All rights reserved.
//

import UIKit

class BadFoodVC: UIViewController {
    
    @IBOutlet weak var badFoodView: UITextView!
    var badFoodArray = [String]()
    var badFoodToShow = ""
    var badFoodDefaults = UserDefaults.standard
    var goodFoodArray = [String]()
    var randomGoodFood = ""
    
    // retrieve previously-inputed bad foods in array form
    // append newest food input to array if not already contained within
    // write out to badFoodView
    override func viewDidLoad() {
        super.viewDidLoad()
        badFoodArray = badFoodDefaults.object(forKey: "savedBadFoodArray") as? [String] ?? [String]()
        if badFoodToShow != "" {
            if !badFoodArray.contains(badFoodToShow){
                badFoodArray.append(badFoodToShow)
            }
        }
        for badFood in badFoodArray {
            badFoodView.text.append("-\(badFood)")
            if badFoodArray.index(of: badFood) != badFoodArray.count-1 {
                badFoodView.text.append("\n")
            }
        }
    }
    
    // remove just-added "bad" food
    // if just viewing, send mistap alert
    @IBAction func undoAdd(_ sender: Any) {
        if badFoodToShow != "" {
            badFoodArray.remove(at: badFoodArray.count-1)
            badFoodView.text = ""
            for badFood in badFoodArray {
                badFoodView.text.append("-\(badFood)")
                if badFoodArray.index(of: badFood) != badFoodArray.count-1 {
                    badFoodView.text.append("\n")
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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if badFoodView.text != "" {
            doneEditing()
        }
        if badFoodToShow != "" {
            suggestionAlert()
        }
        else {
            segueBack()
        }
    }
    
    // re-write defaults to incorporate newest food input and/or list edits
    func doneEditing() {
        badFoodView.resignFirstResponder()
        badFoodArray = badFoodView.text.components(separatedBy: "\n-")
        let firstItem = badFoodArray[0]
        let firstTruncIndex = firstItem.index(firstItem.startIndex, offsetBy: 1)
        let truncFirstItem = firstItem.substring(from: firstTruncIndex)
        badFoodArray[0] = truncFirstItem
        badFoodDefaults.set(badFoodArray, forKey: "savedBadFoodArray")
    }
    
    // suggest a healthier alternative to the inputed "bad" food
    func suggestionAlert() {
        goodFoodArray = badFoodDefaults.object(forKey: "savedGoodFoodArray") as? [String] ?? [String]()
        let randomGoodFoodIndex = Int(arc4random_uniform(UInt32(goodFoodArray.count)))
        randomGoodFood = goodFoodArray[randomGoodFoodIndex]
        let suggestion = UIAlertController(title: "Quick tip", message: "We noticed that \(badFoodToShow) made you feel overstuffed and sluggish, but that \(randomGoodFood) made you feel happy & energized. Try to grab \(randomGoodFood) instead of \(badFoodToShow) next time.", preferredStyle: UIAlertControllerStyle.alert)
        suggestion.addAction(UIAlertAction(title: "Ok, maybe.", style: UIAlertActionStyle.default, handler: { (action) in self.segueBack() }))
        self.present(suggestion, animated: true, completion: nil)
    }
    
    // return to initial view
    func segueBack(){
        self.performSegue(withIdentifier: "backToMenuFromBad", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
