//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Aaron Cabreja on 1/14/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var photos = PhotoJournalModel.getPhotoJournal()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
   
    override func viewWillAppear(_ animated: Bool) {
         photos = PhotoJournalModel.getPhotoJournal()
        collectionView.reloadData()
        
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
        return cell
    }

}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 400, height: 400)
    }
}
