//
//  ChatRoomTest.swift
//  joeDemo
//
//  Created by User on 1/14/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct ChatRoom{
    
    var userName: String!
    var otherUserName: String!
    var userID: String!
    var otherUserID: String!
    var members: [String]!
    var chatRoomID: String!
    var lastMessage: String!
    var key: String = ""
    var ref: DatabaseReference!
    
    init(snapshot: DataSnapshot){
        self.userName = (snapshot.value as? [String : String])?["userName"]
        self.otherUserName = (snapshot.value as? [String : String])?["otherUserName"]
        self.userID = (snapshot.value as? [String : String])?["userID"]
        self.otherUserID = (snapshot.value as? [String : String])?["otherUserID"]
        self.members = (snapshot.value as? [String : [String]])?["members"]
        self.chatRoomID = (snapshot.value as? [String : String])?["chatRoomID"]
        self.lastMessage = (snapshot.value as? [String : String])?["lastMessage"]
        self.key = snapshot.key
        self.ref = snapshot.ref
       
    }
    
    init(userName: String, otherUserName: String, userID: String, otherUserID: String, members: [String],
         chatRoomID: String, lastMessage: String, key: String = ""){
        
        self.userName = userName
        self.otherUserName = otherUserName
        self.userID = userID
        self.otherUserID = otherUserID
        self.members = members
        self.chatRoomID = chatRoomID
        self.lastMessage = lastMessage
   }
    
    func toAnyObject() -> [String: AnyObject]{
        return ["userName": userName as String! as AnyObject, "otherUserName":otherUserName as AnyObject,"userID":otherUserID as AnyObject, "members": members as AnyObject, "chatRoomID": chatRoomID as AnyObject, "lastMessage": lastMessage as AnyObject]
    }
}


