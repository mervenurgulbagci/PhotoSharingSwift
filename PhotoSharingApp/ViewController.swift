//
//  ViewController.swift
//  PhotoSharingApp
//
//  Created by Merve Nurgül BAĞCI on 14.03.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){
            (authdataresult, error) in
                if error != nil{
                    self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Try again.")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            
            }
            
        }
            else{
            errorMessage(titleInput: "Error!", messageInput: "Enter the username and password")
        }
        
    }
    

    @IBAction func signupClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){
            (authdataresult, error) in
                if error != nil{
                    self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Try again.")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            
            }
            
        }
            else{
            errorMessage(titleInput: "Error!", messageInput: "Enter the username and password")
        }
        
    }
    
    func errorMessage(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

