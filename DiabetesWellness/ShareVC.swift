//
//  ShareVC.swift
//  Food Awareness
//
//  Created by Susie Choi on 7/11/17.
//  Copyright © 2017 Susie Choi. All rights reserved.
//
import UIKit
import Social

class ShareVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var foodToShare = ""
    @IBOutlet weak var foodTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTextView!.layer.borderWidth = 0.25
        foodTextView!.layer.borderColor = UIColor.lightGray.cgColor
        if foodToShare != "" {
            foodTextView.text = "Just made a delicious and healthy meal: \(foodToShare)!"
        }
    }
    
    @IBAction func selectImage(_ sender: Any) {
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(ImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func upload(_ sender: Any) {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        if imageView.image != nil {
            vc?.add(imageView.image!)
        }
        vc?.setInitialText(foodTextView.text)
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        confirmAlert()
    }
    
    func confirmAlert() {
        let alert = UIAlertController(title: "Confirm exit", message: "Are you sure you want to go back to the previous screen? Changes will not be saved.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes, go back", style: UIAlertActionStyle.default, handler: { (action) in self.goBackToGoodList() }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil) }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goBackToGoodList() {
        foodTextView.text = ""
        self.performSegue(withIdentifier: "backToGoodList", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
