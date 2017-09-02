//
//  ViewController.swift
//  DiabetesWellness
//
//  Created by Daniel Blue, Susie Choi, & Eleanor Wood on 7/7/17.
//  Copyright © 2017 dataplustwelve. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var emailTextField: UITextField!
  
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
        
    @IBOutlet weak var signOutButton: UIButton!
    var isSignIn:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
//        
//         //if SignIn Selector == False (Register)
//        isSignIn = !isSignIn
//        //Change button Label
//        if isSignIn{
//            signInButton.setTitle("Sign in", for: .normal)
//        }
//        else {
//            signInButton.setTitle("Register", for: .normal)
//        }
//    }
    
    // dismiss keyboard if tapped outside text view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func signInSelectorDidChange(_ sender: Any) {
                 //if SignIn Selector == False (Register)
                isSignIn = !isSignIn
                //Change button Label
                if isSignIn{
                    signInButton.setTitle("Sign in", for: .normal)
                }
                else {
                    signInButton.setTitle("Register", for: .normal)
                }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        //validation on email/password
        if let email = emailTextField.text, let pass = passwordTextField.text{
            
            //Check if sign in or register
            if isSignIn{
                //sign in user with firebase
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error)in
                    if user != nil{
                        //UserFound go to homepage
                        self.performSegue(withIdentifier: "GoToHome", sender: self)
                    }
                    else {
                        //Error
                    }
                })
            }
            else{
                //register user with firebase
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                    if user != nil{
                        //User Created send to homepage
                        self.performSegue(withIdentifier: "GoToHome", sender: self)
                    }
                    else {
                        //Error
                    }
                })
            }
        }
    }

    @IBAction func signOutButtonTapped (_sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "GoToHome", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

