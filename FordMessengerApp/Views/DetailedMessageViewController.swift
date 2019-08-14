//
//  DetailedMessageViewController.swift
//  FordMessengerApp
//
//  Created by fordlabs on 14/08/19.
//  Copyright © 2019 fordlabs. All rights reserved.
//

import Foundation
import UIKit

import SnapKit

class DetailedMessageViewController: UIViewController {
    
    let detailedMessageViewCellId = "detailedMessageViewCellId"
    
    var myMessageCount = 0
    
    var myFriendMessageCount = 0
    
    var isMeAFirstMessenger = false
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    var currentName: String
    var messageList: MessageModel
    
    private let messageListTableView : UITableView = {
        let messageListTableView = UITableView()
        messageListTableView.accessibilityIdentifier = "messageListTableView"
        messageListTableView.translatesAutoresizingMaskIntoConstraints = false
        messageListTableView.allowsSelection = true
        return messageListTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isMeAFirstMessenger = (messageList.friendsList[currentName])!
        setUpViews()
        
    }
    
    init(currentName: String, isMeAFirstMessenger: Bool, messageList: MessageModel){
        self.currentName = currentName
        self.isMeAFirstMessenger = isMeAFirstMessenger
        self.messageList = messageList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        view.backgroundColor = .white
        self.navigationItem.title = currentName
        view.addSubview(messageListTableView)
        messageListTableView.snp.makeConstraints { (make) in
            make.top.equalTo(topbarHeight+0)
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        messageListTableView.register(DetailedMessageListCell.self, forCellReuseIdentifier: detailedMessageViewCellId)
        messageListTableView.delegate = self
        messageListTableView.dataSource = self
        
    }
    
}

extension DetailedMessageViewController: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (messageList.myFriendsMessagesToMe[currentName]?.count)! + (messageList.myMessagesToMyFriends[currentName]?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailedMessageViewCellId, for: indexPath) as! DetailedMessageListCell
        let myMessageSize = (messageList.myFriendsMessagesToMe[currentName]?.count)!
        let myFriendsMessageSize = (messageList.myMessagesToMyFriends[currentName]?.count)!
        let myMessageList = messageList.myMessagesToMyFriends[currentName]
        let myFriendMessageList = messageList.myFriendsMessagesToMe[currentName]
        if(isMeAFirstMessenger){
            if(myMessageCount < myMessageSize){
                cell.currentName = "Me"
                cell.currentMessage = myMessageList?[myMessageCount]
                myMessageCount+=1
                isMeAFirstMessenger = false
            }
        }else {
            if(myFriendMessageCount < myFriendsMessageSize){
                cell.currentName = currentName
                cell.currentMessage = myFriendMessageList?[myFriendMessageCount]
                myFriendMessageCount+=1
                isMeAFirstMessenger = true
            }
        }
        return cell
    }
}
