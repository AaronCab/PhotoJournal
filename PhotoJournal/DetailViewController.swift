//
//  DetailViewController.swift
//  PhotoJournal
//
//  Created by Aaron Cabreja on 1/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var camerButton: UIBarButtonItem!
    @IBOutlet weak var decriptionText: UITextView!
    
    @IBOutlet weak var detailImage: UIImageView!
    private var imagePickerViewController: UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePickerViewController()
        updateUI()
        // Do any additional setup after loading the view.
    }
    private func showImagePickerController(){
        present(imagePickerViewController, animated: true, completion: nil)
    }
    private func updateUI(){
        if let photoJournal =  PhotoJournalModel.getPhotoJournal(){
            let image = UIImage(data: photoJournal.imageData)
            detailImage.image = image
        } else {
            print("there is no image")
        }
    }
    private func setupImagePickerViewController(){
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            camerButton.isEnabled = false
        }
    }
    private func savePhoto(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.5){
            let photoJournal = Photo.init(imageData: imageData, title: "Title", description: description, createdAt: "no date")
            PhotoJournalModel.savePhotoJournal(photoJournal: photoJournal)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            detailImage.image = image
            savePhoto(image: image)
        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func photoLibraryButton(_ sender: UIBarButtonItem) {
        showImagePickerController()
    }
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
    }
}

