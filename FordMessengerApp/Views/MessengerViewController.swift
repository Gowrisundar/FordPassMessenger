//
//  ViewController.swift
//  FordMessengerApp
//
//  Created by fordlabs on 14/08/19.
//  Copyright © 2019 fordlabs. All rights reserved.
//

import UIKit
import SnapKit

class MessengerViewController: UIViewController {
    
    private let messageTableViewCellId = "messageTableViewCellId"
    
    var messageList : MessageModel!
    
    weak var delegate: MessengerViewControllerDelegate!
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    private let messageHeaderLabel : UILabel = {
        let messageHeaderLabel = UILabel()
        messageHeaderLabel.accessibilityIdentifier = "messageHeaderLabel"
        messageHeaderLabel.textAlignment = .center
        messageHeaderLabel.text = "Ford Pass Messenger"
        messageHeaderLabel.font = UIFont(name: "Georgia-Bold", size: 30.0)
        messageHeaderLabel.backgroundColor = .gray
        messageHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageHeaderLabel
    }()

    private let messageListTableView : UITableView = {
        let messageListTableView = UITableView()
        messageListTableView.accessibilityIdentifier = "messageListTableView"
        messageListTableView.translatesAutoresizingMaskIntoConstraints = false
        messageListTableView.allowsSelection = true
        return messageListTableView
    }()
    
    
    private let addContactsButton: UIButton = {
            let addContactsButton = UIButton()
            addContactsButton.accessibilityIdentifier = "addContactsButton"
            addContactsButton.setTitle("Add Contacts", for: .normal)
            addContactsButton.setTitleColor(UIColor.blue, for: .normal)
            addContactsButton.titleLabel?.textAlignment = .center
            addContactsButton.translatesAutoresizingMaskIntoConstraints = false
            return addContactsButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        createMessageList()
    }

    func setUpViews(){
        
        view.addSubview(messageHeaderLabel)
        messageHeaderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topbarHeight+0)
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().multipliedBy(0.17)
        }
        
        view.addSubview(messageListTableView)
        messageListTableView.snp.makeConstraints { (make) in
            make.top.equalTo(messageHeaderLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-70)
        }
        
        view.addSubview(addContactsButton)
        addContactsButton.snp.makeConstraints { (make) in
            make.top.equalTo(messageListTableView.snp.bottom)
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
        
        
        messageListTableView.register(MessageListCell.self, forCellReuseIdentifier: messageTableViewCellId)
        messageListTableView.dataSource = self
        messageListTableView.delegate = self
        
        addContactsButton.addTarget(self, action: #selector(addContactsButtonTapped), for: .touchUpInside)
        
    }
    
}


extension MessengerViewController: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageTableViewCellId, for: indexPath) as! MessageListCell
        cell.currentFriendName = Array(messageList.friendsList)[indexPath.row].key
        cell.messageList = messageList
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @objc func addContactsButtonTapped(_ sender: UIButton)  {
        delegate.addContactsButtonTapped()
    }
    
    func createMessageList(){
        messageList = MessageModel(friendsList: createFriendList(), myMessagesToMyFriends: createMyMessageToMyFriends(), myFriendsMessagesToMe: createMyFriendsMessagesToMe())
    }
    
    func createFriendList() -> [String : Bool] {
        return ["Tamil" : true, "Karthick" : false]
    }
    
    func createMyMessageToMyFriends() -> [String: [String]] {
        return ["Tamil" : ["Hi da","How are you"], "Karthick" : ["Hi da", "I am Good"]]
    }
    
    func createMyFriendsMessagesToMe() -> [String: [String]]  {
        return ["Tamil" : ["Hi da","I am Fine"], "Karthick" : ["Hi da","How are you"]]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentName = Array(messageList.friendsList)[indexPath.row].key
        let isMeAFirstMessenger = Array(messageList.friendsList)[indexPath.row].value
        delegate.didRowSelected(currentName, isMeAFirstMessenger, messageList)
    }
}


protocol MessengerViewControllerDelegate: class {
    
    func addContactsButtonTapped()
    func didRowSelected(_ currentName: String, _ isMeAFirstMessenger:Bool, _ messageList: MessageModel)
    
}
