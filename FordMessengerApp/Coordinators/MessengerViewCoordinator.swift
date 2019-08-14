//
//  MessengerViewCoordinator.swift
//  FordMessengerApp
//
//  Created by fordlabs on 14/08/19.
//  Copyright © 2019 fordlabs. All rights reserved.
//

import Foundation
import UIKit

class MessengerViewCoordinator: Coordinator{
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let messengerViewController = MessengerViewController()
        messengerViewController.delegate = self
        navigationController.pushViewController(messengerViewController, animated: true)
    }
    
}

extension MessengerViewCoordinator: MessengerViewControllerDelegate {
    
    func didRowSelected(_ currentName: String, _ isMeAFirstMessenger: Bool, _ messageList: MessageModel) {
        navigationController.pushViewController(DetailedMessageViewController(currentName: currentName, isMeAFirstMessenger: isMeAFirstMessenger, messageList: messageList), animated: true)
    }
    
    func addContactsButtonTapped() {
        print("Add Contacts Button Tapped")
    }
    
    
}
