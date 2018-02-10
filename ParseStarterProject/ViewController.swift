/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupMode = true

    @IBOutlet var errorLabel: UILabel!
    
    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var signupOrLoginButton: UIButton!
    
    @IBOutlet var changeSignupModeButton: UIButton!
    
    // function to sign up or login user
    
    @IBAction func signupOrLogin(_ sender: AnyObject) {
        
        if signupMode {
        
        let user = PFUser()
        
        user.username = usernameField.text
        user.password = passwordField.text
            
        let acl = PFACL()
            
        acl.getPublicWriteAccess = true
        acl.getPublicReadAccess = true
            
        user.acl = acl
       
        user.signUpInBackground { (success, error) in
            
            if error != nil {
                
                var errorMessage = "Signup failed - please try again"
                
                let error = error as? NSError
                
                if let parseError = error?.userInfo["error"] as? String {
                    
                    errorMessage = parseError
                    
                }
                
                self.errorLabel.text = errorMessage
                
            } else {
                
                print("Signed up")
                
                self.performSegue(withIdentifier: "goToUserInfo", sender: self)
                
            }
            
            
        }
        
        } else {
            
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!, block: { (user, error) in
                
                
                if error != nil {
                    
                    var errorMessage = "Signup failed - please try again"
                    
                    let error = error as? NSError
                    
                    if let parseError = error?.userInfo["error"] as? String {
                        
                        errorMessage = parseError
                        
                    }
                    
                    self.errorLabel.text = errorMessage
                    
                } else {
                    
                    print("Logged In")
                    
                    self.redirectUser()
                    
                }
                
            })
            
        }
        
    }
    
    // function that changes signup/login mode
    
    @IBAction func changeSignupMode(_ sender: AnyObject) {
        
        if signupMode {
            
            signupMode = false
            
            signupOrLoginButton.setTitle("Log In", for: [])
            
            changeSignupModeButton.setTitle("Sign Up", for: [])
            
        } else {
            
            signupMode = true
            
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            changeSignupModeButton.setTitle("Log In", for: [])
            
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
      //redirectUser()
        
    }
    
    func redirectUser() {
        
        if PFUser.current() != nil {
            
            if PFUser.current()?["isFemale"] != nil && PFUser.current()?["isInterestedInWomen"] != nil && PFUser.current()?["photo"] != nil {
                
                performSegue(withIdentifier: "swipeFromInitialSegue", sender: self)
                
                
            } else {
                
                performSegue(withIdentifier: "goToUserInfo", sender: self)
                
            }
            
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        signupOrLoginButton.layer.cornerRadius = 6
        
        signupOrLoginButton.clipsToBounds = true
        
        changeSignupModeButton.layer.cornerRadius = 6
        
        changeSignupModeButton.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
