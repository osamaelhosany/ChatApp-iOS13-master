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
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var tableView : UITableView!
    
    var messages = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName,bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        getUserMessages()
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
                       let receiverId = data[K.FStore.bodyField] as? String,
                       let createdDate = data[K.FStore.createdDateField] as? String,
                       let timeStamp = data[K.FStore.timeStampField] as? String {
                        
                        self.messages.append(Message(receiverId: receiverId , sender: sender , body: body, createdDate: createdDate, timeStamp: timeStamp ))
                    }
                    
                }
                
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }}
    
    @IBAction func sendPressed(_ sender: UIButton) {
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
                self.messageTextfield.text = ""
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        as? MessageCell
        cell?.label?.text = messages[indexPath.row].body
        return cell!
    }
    
    
}

extension ChatViewController : UITableViewDelegate{
    
    func tableView(_ tableView : UITableView, didSelectRowAt index : IndexPath){
        print(index.row)
    }
}
