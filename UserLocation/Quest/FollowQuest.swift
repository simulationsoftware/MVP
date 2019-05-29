//
//  FollowQuest.swift
//  UserLocation
//
//  Created by Alvaro Sanchez on 5/28/19.
//  Copyright © 2019 Alvaro Sanchez. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FollowQuestController: UIViewController {
    
    
    
    let markButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.backgroundColor = .gray
        butt.setTitle("Mark", for: .normal)
        butt.setTitleColor(.black, for: .normal)
        butt.addTarget(self, action: #selector(getData), for: .touchUpInside)
        butt.layer.cornerRadius = 8.0
        return butt
    }()


    @objc func getData() {
    let db = Firestore.firestore()
    let docRef = db.collection("Log").document("79ZybF5Tvt3XmGgTVOI2")
        docRef.getDocument() { (document, error) in
        if let document = document, document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
        } else {
            print("Document does not exist")
        }
    }
    }
    
    
    override func viewDidLoad() {
        
        view.addSubview(markButton)
        
        _ = markButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 10, rightConstant: 40, heightConstant: 30)
        
    }
    
    
}
