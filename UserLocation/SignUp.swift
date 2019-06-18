//
//  creatUser.swift
//  UserLocation
//
//  Created by Alvaro Sanchez on 5/22/19.
//  Copyright © 2019 Alvaro Sanchez. All rights reserved.
//

import Foundation
import Firebase

class SignupController: UIViewController {
    let myColor = UIColor(hue: 300, saturation: 60, brightness: 100, alpha: 0.2)
    
    //Background image
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "muse")
        iv.clipsToBounds = true
        return iv
    }()

    //Email text field
    weak var email: UITextField! = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.placeholder = "Email"
        textfield.keyboardType = .emailAddress
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.cornerRadius = 8.0
        textfield.textAlignment = .center
        return textfield
    }()

    //Password text field
    weak var password: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.layer.cornerRadius = 8.0
        tf.textAlignment = .center
        return tf
    }()

    //Password confirm text field
    weak var passwordConfirm: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Re-Type Password"
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.layer.cornerRadius = 8.0
        tf.textAlignment = .center
        return tf
    }()

    //Seperator
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Seperator 2
    let seperatorToo: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //Register button
    let registerButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.backgroundColor = .gray
        butt.setTitle("Register", for: .normal)
        butt.setTitleColor(.black, for: .normal)
        butt.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        butt.layer.cornerRadius = 8.0
        return butt
    }()

    //Button that takes user to sign in page
    let signIn: UIButton = {
        let si = UIButton(type: .system)
        si.backgroundColor = .gray
        si.setTitle("Sign In", for: .normal)
        si.setTitleColor(.blue, for: .normal)
        si.addTarget(self, action: #selector(signin), for: .touchUpInside)
        si.layer.cornerRadius = 8.0
        return si
    }()


    //Function changes view to Sign in page
    @objc func signin() {
        let logincontroller = SignInController()
        present(logincontroller, animated: true, completion: {})
    }

    //This function signs up user in database, and if no errors send user to map view
    @objc func signUpAction(_ sender: Any) {
        if password.text != passwordConfirm.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error == nil {
                    //saving to db
                    var ref: DocumentReference? = nil
                    let db = Firestore.firestore()
                    let values = ["email": self.email.text]
                    ref = db.collection("users").addDocument(data: values as [String : Any]){ err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
                    let tutorialcontroller = MapViewController()
                    self.present(tutorialcontroller, animated: true, completion: {})
                }
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
        view.addSubview(passwordConfirm)
        view.addSubview(seperatorView)
        view.addSubview(registerButton)
        view.addSubview(seperatorToo)
        view.addSubview(signIn)

        _ = backgroundImageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = email.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 446, leftConstant: 15, bottomConstant: 0, rightConstant: 15, heightConstant: 50)
        
        _ = seperatorView.anchor(email.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, heightConstant: 1)
        
        _ = password.anchor(email.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15,  heightConstant: 50)
        
        _ = seperatorToo.anchor(password.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, heightConstant: 1)
        
        _ = passwordConfirm.anchor(seperatorToo.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, heightConstant: 50)
        
        _ = registerButton.anchor(passwordConfirm.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 30, bottomConstant: 0, rightConstant: 30, heightConstant: 50)
        
        _ = signIn.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 10, rightConstant: 40, heightConstant: 30)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
