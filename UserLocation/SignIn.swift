//
//  SignIn.swift
//  UserLocation
//
//  Created by Alvaro Sanchez on 5/28/19.
//  Copyright © 2019 Alvaro Sanchez. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    let myColor = UIColor(hue: 300, saturation: 60, brightness: 100, alpha: 0.2)
    
    //BACKGROUND IMAGE
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "muse")
        iv.clipsToBounds = true
        return iv
    }()
    
    //EMAIL TEXT FIELD
    lazy var email: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.placeholder = "Email"
        textfield.keyboardType = .emailAddress
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.cornerRadius = 8.0
        textfield.textAlignment = .center
        return textfield
    }()
    
    //PASSWORD TEXT FIELD
    let password: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.layer.cornerRadius = 8.0
        tf.textAlignment = .center
        return tf
    }()
    
    //SEPERATOR
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //REGISTER BUTTON
    let registerButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.backgroundColor = .gray
        butt.setTitle("Sign in", for: .normal)
        butt.setTitleColor(.black, for: .normal)
        butt.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        butt.layer.cornerRadius = 8.0
        return butt
    }()
    
    //BUTTON TO TAKE YOU TO SIGN UP PAGE
    let signUp: UIButton = {
        let su = UIButton(type: .system)
        su.backgroundColor = .gray
        su.setTitle("Create account", for: .normal)
        su.setTitleColor(.blue, for: .normal)
        su.addTarget(self, action: #selector(signup), for: .touchUpInside)
        su.layer.cornerRadius = 8.0
        return su
    }()
    
    //FUNCTION CHANGES VIEW TO SIGN UP CONTROLLER
    @objc func signup() {
        let signupcontroller = SignupController()
        present(signupcontroller, animated: true, completion: {})
    }
    
    //THIS FUNCTION SIGNS IN USER AS LONG AS USER EXIST IN FIREBASE. SENDS USER TO PROFILE PAGE IF NO ERRORS
    @objc func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                let profilecell = MapViewController()
                self.present(profilecell, animated: true, completion: {})
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(seperatorView)
        view.addSubview(registerButton)
        view.addSubview(signUp)
        
        _ = backgroundImageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = email.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 496, leftConstant: 15, bottomConstant: 0, rightConstant: 15, heightConstant: 50)
        
        _ = seperatorView.anchor(email.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, heightConstant: 1)
        
        _ = password.anchor(seperatorView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15,  heightConstant: 50)
        
        _ = registerButton.anchor(password.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 30, bottomConstant: 0, rightConstant: 30, heightConstant: 50)
        
        _ = signUp.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 10, rightConstant: 40, heightConstant: 30)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
}
