//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loader :UIActivityIndicatorView!
    
    @IBAction func registerPressed(_ sender: UIButton) {
    
        loader.startAnimating()
        if let email = emailTextfield.text ,
            let password = passwordTextfield.text
        {
            Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
                
                if let e = error {
                    print(e)
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription , preferredStyle: .actionSheet)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default , handler:{ (UIAlertAction)in
                        self.dismiss(animated: true)
                        }))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }else {
                    
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
    
                self.loader.stopAnimating()

            }
        }
   
    }
    
}
