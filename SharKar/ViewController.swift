//
//  ViewController.swift
//  SharKar
//
//  Created by Mac on 2017/6/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import JSQMessagesViewController

struct User {
    let id: String
    let name: String
}

class ViewController: JSQMessagesViewController {

    let user1 = User(id: "1", name: "Amber")
    let user2 = User(id: "2", name: "Debbie")
    
    var currentUser : User {
        return user1
    }
    
    var messages = [JSQMessage]()
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
}

extension ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()

        self.messages = getMessages()
    }
    
}

extension ViewController{
    func getMessages() -> [JSQMessage]{
        
        var messages = [JSQMessage]()
        
        let message1 = JSQMessage(senderId: "1", displayName: "Amber", text: "Hey How are you")
        let message2 = JSQMessage(senderId: "2", displayName: "Debbie", text: "Hey How are you")
        
        messages.append(message1!)
        messages.append(message2!)
        
        
        return messages
    }
}



