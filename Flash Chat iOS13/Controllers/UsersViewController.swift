//
//  UsersViewController.swift
//  Flash Chat iOS13
//
//  Created by Osama El Hussiny on 4/20/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

class UsersViewController : UIViewController {
    var recipientId : String?
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    var users = [User(userId : "G9bfbkbb9kZnbt1HojRVspku3Eq1", userName : "osama" , fullName : "osama mohamed tawfik", jobTitle : "software" , bio : "" ),
                 User(userId : "G9bfbkbb9kZnbt1HojRVspku3Eq1",userName : "osama" , fullName : "osama mohamed tawfik", jobTitle : "software" , bio : "" ),
                 User(userId : "G9bfbkbb9kZnbt1HojRVspku3Eq1",userName : "osama" , fullName : "osama mohamed tawfik", jobTitle : "software" , bio : "" ),
                 User(userId : "G9bfbkbb9kZnbt1HojRVspku3Eq1",userName : "osama" , fullName : "osama mohamed tawfik", jobTitle : "software" , bio : "" ),
                 User(userId : "G9bfbkbb9kZnbt1HojRVspku3Eq1",userName : "osama" , fullName : "osama mohamed tawfik", jobTitle : "software" , bio : "" ),
                 User(userId : "G9bfbkbb9kZnbt1HojRVspku3Eq1",userName : "osama" , fullName : "osama mohamed tawfik", jobTitle : "software" , bio : "" ),
                 User(userId : "G9bfbkbb9kZnbt1HojRVspku3Eq1",userName : "osama" , fullName : "osama mohamed tawfik", jobTitle : "software" , bio : "" )]
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 5, bottom: 5, right: 0)

    
    override func viewDidLoad(){
        super.viewDidLoad()
        activityIndicator.startAnimating()
        
        collectionView.dataSource =  self
        collectionView.delegate = self
//        collectionView.register(UINib(nibName: K.userViewCell,bundle: nil), forCellWithReuseIdentifier: K.userViewCellIdentifier)
        
        activityIndicator.stopAnimating()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? ChatViewController {
//            vc.recipientId = self.recipientId
//        }
//    }
    
}

extension UsersViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView : UICollectionView, didSelectItemAt index : IndexPath){
        print(index.row)
        self.recipientId = users[index.row].userId
        let destinationVC = ChatViewController()
          destinationVC.recipientId = users[index.row].userId

          // Let's assume that the segue name is called playerSegue
          // This will perform the segue and pre-load the variable for you to use
      //  destinationVC.performSegue(withIdentifier: K.usersToChat, sender: self)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension UsersViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let user = users[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.userViewCellIdentifier, for: indexPath)
        as! UserViewCell
        
        cell.nameLabel?.text = user.fullName
        
        return cell
    }
    
    
}

// MARK: - Collection View Flow Layout Delegate
extension UsersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zeros
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {

            let paddingSpace = sectionInsets.left * 4
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem  = availableWidth/2

           return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
   
}


