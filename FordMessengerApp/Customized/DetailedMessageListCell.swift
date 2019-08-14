//
//  DetailedMessageListCell.swift
//  FordMessengerApp
//
//  Created by fordlabs on 14/08/19.
//  Copyright © 2019 fordlabs. All rights reserved.
//

import Foundation
import UIKit

class DetailedMessageListCell: UITableViewCell {
    
    var currentName : String? {
        didSet{
            currentContactName.text = currentName
        }
    }
    
    var currentMessage: String? {
        didSet{
            currentContactLastMessage.text = currentMessage
        }
    }
    
    
    let currentContactName : UILabel = {
        let currentContactName = UILabel()
        currentContactName.font = UIFont(name: "Georgia-Bold", size: 20.0)
        currentContactName.translatesAutoresizingMaskIntoConstraints = false
        return currentContactName
    }()
    
    let currentContactLastMessage : UILabel = {
        let currentContactLastMessage = UILabel()
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
    
    func buildViews(){
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
