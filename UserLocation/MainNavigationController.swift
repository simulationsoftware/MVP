//
//  MainNavigationController.swift
//  UserLocation
//
//  Created by Alvaro Sanchez on 5/23/19.
//  Copyright © 2019 Alvaro Sanchez. All rights reserved.
//

import UIKit
import Firebase

class MainNavigationController: UINavigationController {


    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        //THIS ALLOWS USER TO STAY LOGGED IN IF THEY LEAVE THE APP WITHOUT LOGGING OUT
        if Auth.auth().currentUser != nil {
            //let mapcell = MapViewController()
            //self.present(mapcell, animated: true, completion: {})
        }
    }

    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = .white
        perform(#selector(showLoginController), with: nil, afterDelay: 0.00)
    }

    //THIS FUNCTION PRESENTS THE VIEW LOGINCONTROLLER.
    @objc func showLoginController(){
        let loginController = SignupController()
        present(loginController, animated: true, completion: {})
    }
}
