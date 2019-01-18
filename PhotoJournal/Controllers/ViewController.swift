//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Aaron Cabreja on 1/14/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var photos = PhotoJournalModel.getPhotoJournal(){
        didSet {
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
   
    override func viewWillAppear(_ animated: Bool) {
         photos = PhotoJournalModel.getPhotoJournal()
        
    }
    
  
    @IBAction func editButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .actionSheet)
        
        let shareButton = UIAlertAction(title: "Share", style: .default, handler: { (action) in
            
        })
        let editButton = UIAlertAction(title: "Edit", style: .default, handler: { (action) in
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let viewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewID") as? DetailViewController else { return }
            
                        self.present(viewController, animated: true, completion: nil)
           
            viewController.decriptionText.text = self.photos[sender.tag].description
            PhotoJournalModel.updateItem(updatedItem: self.photos[sender.tag], atIndex: sender.tag)

            self.photos = PhotoJournalModel.getPhotoJournal()


        })
        
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            PhotoJournalModel.delete(atIndex: sender.tag)
            self.photos = PhotoJournalModel.getPhotoJournal()
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }

            alert.addAction(shareButton)

            alert.addAction(editButton)
            alert.addAction(deleteButton)
            alert.addAction(cancelButton)
       
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell()}
        let dataToSet = photos[indexPath.row]
        cell.descriptionLabel.text = dataToSet.description
        cell.dateLabel.text = dataToSet.createdAt
        cell.photoImage.image = UIImage(data: dataToSet.imageData)
        cell.layer.cornerRadius = 175
        cell.editButton.tag = indexPath.row
        return cell
    }
    

}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 400, height: 400)
    }
}
