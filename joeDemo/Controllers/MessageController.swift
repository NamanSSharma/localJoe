//
//  MessageController.swift
//  joeDemo
//
//  Created by User on 1/28/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

class MessageController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "openMessage", sender: self)
    }


}
