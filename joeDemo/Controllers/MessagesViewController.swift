//
//  MessagesViewController.swift
//  joeDemo
//
//  Created by Yudhvir Raj on 2017-11-26.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UITableViewController {

    enum Section: Int {
        case createNewChannelSection = 0
        case currentChannelsSection
    }
    
    // MARK: Properties
    var senderDisplayName: String? // 1
    var newChannelTextField: UITextField? // 2
    private var channels: [Channel] = [] // 3    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkIfUserIsLoggedIn () {
        if Firebase.Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout))
        } else {
            
        }
    }
    
    @objc func handleLogout () {
        do {
            try Firebase.Auth.auth().signOut()
        } catch let logoutError {
            print (logoutError)
        }
    
        let loginController = LoginController()
        present (loginController, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 2
        if let currentSection: Section = Section(rawValue: section) {
            switch currentSection {
            case .createNewChannelSection:
                return 1
            case .currentChannelsSection:
                return channels.count
            }
        } else {
            return 0
        }
    }
    
    // 3
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue ? "NewChannel" : "ExistingChannel"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue {
            if let createNewChannelCell = cell as? CreateChannelCell {
                newChannelTextField = createNewChannelCell.newChannelNameField
            }
        } else if (indexPath as NSIndexPath).section == Section.currentChannelsSection.rawValue {
            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
        }
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
