//
//  ViewController.swift
//  joeDemo
//
//  Created by Naman Sharma on 11/3/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class MessageQuoteController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputComponents()
    }
    
    func setupInputComponents(){
        let containerView = UIView()
        containerView.backgroundColor = UIColor.red
        containerView.translatesAutoresizingMaskIntoConstraints = false;
       
        view.addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true;
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true;
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        
        
    }
    
    
    
    
}



