//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()
    var recipientId : String?
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var tableView : UITableView!
    
    var messages = [Message]()
    init() {
           super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //     activityIndicator.startAnimating()
        navigationItem.title = K.appName

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName,bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        getUserMessages()
     //   activityIndicator.stopAnimating()
    }
    
    func scrollToBottom()  {
        let index = IndexPath(row: self.messages.count - 1, section: 0)
        
        self.tableView.scrollToRow(at: index, at: .top, animated: true)
    }
    
    func getUserMessages() {
        activityIndicator.startAnimating()
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.timeStampField)
            .addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    let alert = UIAlertController(title: "Error", message: "Something went wrong" , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    
                    self.present(alert, animated: true, completion: nil)}
                else {
                    self.messages = []
                    for document in querySnapshot!.documents {
                        
                        let data = document.data()
                        
                        if let body = data[K.FStore.bodyField] as? String ,
                           let sender = data[K.FStore.senderField] as? String ,
                           let senderId = data[K.FStore.senderId] as? String ,
                           let receiverId = data[K.FStore.bodyField] as? String,
                           let createdDate = data[K.FStore.createdDateField] as? String,
                           let timeStamp = data[K.FStore.timeStampField] as? String {
                            
                            self.messages.append(Message(senderId: senderId, receiverId: receiverId , sender: sender , body: body, createdDate: createdDate, timeStamp: timeStamp ))
                        }
                        
                    }
                    
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                        self.scrollToBottom()
                        self.activityIndicator.stopAnimating()
                    }
                }
            }}
    
    @IBAction func sendPressed(_ sender: UIButton) {
        let body = messageTextfield.text
        if  (body ?? "").isEmpty ||
            body!.trimmingCharacters(in: .whitespaces).isEmpty {
            messageTextfield.placeholder = "please insert..."
            messageTextfield.text = ""
            return
        }
        activityIndicator.startAnimating()

        let receiverId = "receiverId"
        if let messageBody = messageTextfield.text,
           let senderEmail = Auth.auth().currentUser?.email ,
           let userID = Auth.auth().currentUser?.uid
        {
            
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField : senderEmail, K.FStore.bodyField : messageBody,
                                                                      K.FStore.senderId : userID,
                                                                      K.FStore.receiverId :  receiverId,
                                                                      K.FStore.createdDateField : "\(Date())",
                                                                      K.FStore.timeStampField : "\(Date().timeIntervalSince1970)"]) { (error) in
                
                if let e = error{
                    print("there is an issue \(e)")
                    return
                }
                
                DispatchQueue.main.async{
                    self.messageTextfield.text = ""
                    self.activityIndicator.stopAnimating()
                }
                
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem){
        
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        as! MessageCell
        
        cell.label?.text = message.body
        
        if message.senderId == Auth.auth().currentUser?.uid {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
        }else {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
    
    
}

extension ChatViewController : UITableViewDelegate{
    
    func tableView(_ tableView : UITableView, didSelectRowAt index : IndexPath){
        print(index.row)
    }
}
