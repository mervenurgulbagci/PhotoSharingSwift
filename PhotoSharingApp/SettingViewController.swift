//
//  SettingViewController.swift
//  PhotoSharingApp
//
//  Created by Merve Nurgül BAĞCI on 15.03.2022.
//

import UIKit
import Firebase
class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
    
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        } catch  {
            print("Error")
        }
        
    }
    
}
