//
//  MessageTest.swift
//  joeDemo
//
//  Created by User on 1/13/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct MessageTest{
    
    var text: String!
    var senderID: String!
    var userName: String!
    var ref: DatabaseReference!
    var key: String!
    
    init(snapshot: DataSnapshot){
        self.text = (snapshot.value as? [String : String])?["text"]
        self.senderID = (snapshot.value as? [String : String])?["senderID"]
        self.userName = (snapshot.value as? [String : String])?["userName"]
        self.ref = snapshot.ref
        self.key = snapshot.key
 
    }
    
    init(text:String, key: String = "", senderID: String, userName: String){
        self.text = text
        self.senderID = senderID
        self.userName = userName
    }
    
    func toAnyObject() -> [String: AnyObject]{
        return ["text": text as AnyObject, "senderID": senderID as AnyObject, "userName": userName as AnyObject]
    }
    
}
