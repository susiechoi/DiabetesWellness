//
//  GoodFoodVC.swift
//  Food Awareness
//
//  Created by Susie Choi on 6/28/17.
//  Copyright © 2017 Susie Choi. All rights reserved.
//
import UIKit
import EventKit

class GoodFoodVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var goodFoodView: UITextView!
    var goodFoodArray = [String]()
    var goodFoodToShow = ""
    var goodFoodDefaults = UserDefaults.standard
    
    // retrieve previously-inputed good foods in array form
    // append newest food input to array if not already contained within
    // write out to goodFoodView
    override func viewDidLoad() {
        super.viewDidLoad()
        goodFoodArray = goodFoodDefaults.object(forKey: "savedGoodFoodArray") as? [String] ?? [String]()
        if goodFoodToShow != ""{
            if !goodFoodArray.contains(goodFoodToShow){
                goodFoodArray.append(goodFoodToShow)
            }
        }
        for goodFood in goodFoodArray {
            goodFoodView.text.append("-\(goodFood)")
            if goodFoodArray.index(of: goodFood) != goodFoodArray.count-1 {
                goodFoodView.text.append("\n")
            }
        }
    }
    
    // remove just-added "good" food
    // if just viewing, send mistap alert
    @IBAction func undoAdd(_ sender: Any) {
        if goodFoodToShow != "" {
            goodFoodArray.remove(at: goodFoodArray.count-1)
            goodFoodView.text = ""
            for goodFood in goodFoodArray {
                goodFoodView.text.append("-\(goodFood)")
                if goodFoodArray.index(of: goodFood) != goodFoodArray.count-1 {
                    goodFoodView.text.append("\n")
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
    
    @IBAction func shareToFacebook(_ sender: Any) {
        performSegue(withIdentifier: "shareSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shareSegue" {
            let destination = segue.destination as! ShareVC
            if goodFoodToShow != "" {
                destination.foodToShare = goodFoodToShow
            }
        }
    }
    
    // return to initial view
    @IBAction func backButtonTapped(_ sender: Any) {
        if goodFoodView.text != "" {
            doneEditing()
        }
        if goodFoodToShow != "" {
            reminderOption()
        }
        else {
            segueBack()
        }
    }
    
    func doneEditing() {
        goodFoodView.resignFirstResponder()
        goodFoodArray = goodFoodView.text.components(separatedBy: "\n-")
        let firstItem = goodFoodArray[0]
        let firstTruncIndex = firstItem.index(firstItem.startIndex, offsetBy: 1)
        let truncFirstItem = firstItem.substring(from: firstTruncIndex)
        goodFoodArray[0] = truncFirstItem
        goodFoodDefaults.set(goodFoodArray, forKey: "savedGoodFoodArray")
    }
    
    func segueBack() {
        self.performSegue(withIdentifier: "backToMenuFromGood", sender: self)
    }
    
    // option of adding just-inputed "good" food to grocery reminders list
    func reminderOption() {
        let alert = UIAlertController(title: "Hurray!", message: "Would you like to add \(goodFoodToShow) to your Reminders app so you can pick it up next time you're grocery-shopping?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Sure", style: UIAlertActionStyle.default, handler: { (action) in self.ensureAccessToReminders() }))
        alert.addAction(UIAlertAction(title: "No, thanks.", style: UIAlertActionStyle.default, handler: { (action) in self.segueBack() }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func ensureAccessToReminders() {
        if appDelegate.eventStore == nil {
            appDelegate.eventStore = EKEventStore()
            
            appDelegate.eventStore?.requestAccess(to: EKEntityType.reminder, completion: { (granted, error) in
                if !granted {
                    print("Access not granted")
                } else {
                    print("Access granted")
                }
            })
        }
        if (appDelegate.eventStore != nil) {
            self.createReminder()
        }
    }
    
    // add "good" food to reminders list
    func createReminder() {
        let reminder = EKReminder(eventStore: appDelegate.eventStore!)
        reminder.title = goodFoodToShow
        reminder.calendar = appDelegate.eventStore!.defaultCalendarForNewReminders()
        do {
            try appDelegate.eventStore?.save(reminder, commit: true)
        } catch let error {
            print("Reminder failed with error \(error.localizedDescription)")
        }
        segueBack()
    }
    
    // allow segue back to this VC if user decides not to upload to Facebook
    @IBAction func backToGoodList(segue: UIStoryboardSegue){
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
