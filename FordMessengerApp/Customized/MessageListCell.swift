//
//  MessageListCell.swift
//  FordMessengerApp
//
//  Created by fordlabs on 14/08/19.
//  Copyright © 2019 fordlabs. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MessageListCell: UITableViewCell {
    
    var currentFriendName : String? {
        didSet{
            currentContactName.text = currentFriendName
        }
    }
    
    
    var messageList: MessageModel? {
        didSet{
            getContactNameAndLastMessage()
        }
    }
    
    private let currentContactName : UILabel = {
        let currentContactName = UILabel()
        currentContactName.textAlignment = .left
        currentContactName.font = UIFont(name: "Georgia-Bold", size: 20.0)
        currentContactName.translatesAutoresizingMaskIntoConstraints = false
        return currentContactName
    }()
    
    private let currentContactLastMessage : UILabel = {
        let currentContactLastMessage = UILabel()
        currentContactLastMessage.textAlignment = .left
        currentContactLastMessage.font = UIFont(name: "Georgia-Bold", size: 15.0)
        currentContactLastMessage.translatesAutoresizingMaskIntoConstraints = false
        return currentContactLastMessage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews()  {
        
        addSubview(currentContactName)
        currentContactName.snp.makeConstraints { (make) in
            make.top.equalTo(3)
            make.leading.equalToSuperview().offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(25)
        }
        addSubview(currentContactLastMessage)
        currentContactLastMessage.snp.makeConstraints { (make) in
            make.top.equalTo(currentContactName.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        
    }
    
}


extension MessageListCell {
    
    func getContactNameAndLastMessage(){
        let isMeAFirstMessenger = (messageList?.friendsList[currentFriendName!])!
        let myMessageToMyFriendSize = (messageList?.myMessagesToMyFriends[currentFriendName!]?.count)!
        let myFriendsMessageToMe = (messageList?.myFriendsMessagesToMe[currentFriendName!]?.count)!
        if(myMessageToMyFriendSize > myFriendsMessageToMe){
            currentContactLastMessage.text = messageList?.myMessagesToMyFriends[currentFriendName!]?.last
        }else if(myMessageToMyFriendSize < myFriendsMessageToMe){
            currentContactLastMessage.text = messageList?.myFriendsMessagesToMe[currentFriendName!]?.last
        }else{
            if(isMeAFirstMessenger){
                currentContactLastMessage.text = messageList?.myFriendsMessagesToMe[currentFriendName!]?.last
            }else{
                currentContactLastMessage.text = messageList?.myMessagesToMyFriends[currentFriendName!]?.last
            }
        }
    }
}
