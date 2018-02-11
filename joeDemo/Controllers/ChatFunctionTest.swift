//
//  ChatFunctionTest.swift
//  joeDemo
//
//  Created by User on 1/15/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct ChatFunctions{
    var chatRoomID = String()
    
    private var databaseRef: DatabaseReference!{
        return Database.database().reference()
    }
    
    mutating func startChat (user1: User, user2: User){
        let userID1 = user1.uid
        let userID2 = user2.uid
        
        var chatRoomID = ""
        
        let comparison = userID1.compare(userID2).rawValue
        
      //  let members = [user1.userName!, user2.userName!]
        
        if comparison > 0{
            chatRoomID = userID1 + userID2
        }else{
            chatRoomID = userID2 + userID1
        }
        
        self.chatRoomID = chatRoomID
    //    self.createChatRoomID(user1, user2: user2, members:members, chatRoomID: chatRoomID)
    
    }
    
    private func createChatRoomID(user1: User, user2: User, members: [String], chatRoomID: String){
        
        let chatRoomRef = databaseRef.child("ChatRooms").queryOrdered(byChild: "chatRoomId").queryEqual(toValue: chatRoomID)
        chatRoomRef.observe(.value, with: {(snapshot) in
            var createChatRoom = true
            if snapshot.exists(){
                for chatRoom in (snapshot.value! as AnyObject).allValues {
                    if (snapshot.value as? [String: String])?["chatRoomID"] == chatRoomID{
                        createChatRoom = false
                    }
                }
            }
            
            if createChatRoom{
              /*  self.createNewChatRoomID(userName: user1.userName, otherUserName: user2.userName, userID: user1.uid, otherUserID: user2.uid, members: members, chatRoomID: chatRoomID, lastMessage : "")
            */}
        }) { (error) in
            print("woops")
        }
    }
    
    private func createNewChatRoomID(userName: String, otherUserName: String, userID: String, otherUserID: String,members:[String], chatRoomID: String, lastMessage: String){
        
        let newChatRoom = ChatRoom(userName: userName, otherUserName: otherUserName, userID: userID, otherUserID: otherUserID, members:members, chatRoomID: chatRoomID, lastMessage: lastMessage)
        let chatRoomRef = databaseRef.child("ChatRooms").child(chatRoomID)
        chatRoomRef.setValue(newChatRoom.toAnyObject())
    }
    
    
}
