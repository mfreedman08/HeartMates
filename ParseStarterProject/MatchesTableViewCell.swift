//
//  MatchesTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Rob Percival on 08/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class MatchesTableViewCell: UITableViewCell {
    
    
    @IBOutlet var userIdLabel: UILabel!
    
    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var messageTextField: UITextField!
    
    @IBOutlet var messagesLabel: UILabel!
    
    @IBOutlet var sendButton: UIButton!
    
    // function that sends message
    
    @IBAction func send(_ sender: AnyObject) {
        
        let message = PFObject(className: "Message")
        
        message["sender"] = PFUser.current()?.objectId!
        
        message["recipient"] = userIdLabel.text
        
        message["content"] = messageTextField.text
        
        message.saveInBackground()
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sendButton.layer.cornerRadius = 6
        
        sendButton.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
