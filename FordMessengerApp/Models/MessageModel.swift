//
//  MessageModel.swift
//  FordMessengerApp
//
//  Created by fordlabs on 14/08/19.
//  Copyright © 2019 fordlabs. All rights reserved.
//

import Foundation

class MessageModel {
    
    var friendsList: [String : Bool]
    var myMessagesToMyFriends: [String: [String]]
    var myFriendsMessagesToMe: [String: [String]]
    
    init(friendsList: [String : Bool], myMessagesToMyFriends: [String: [String]] , myFriendsMessagesToMe: [String: [String]]) {
        self.friendsList = friendsList
        self.myMessagesToMyFriends = myMessagesToMyFriends
        self.myFriendsMessagesToMe = myFriendsMessagesToMe
    }
    
}
