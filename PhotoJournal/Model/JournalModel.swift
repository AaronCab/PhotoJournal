//
//  JournalModel.swift
//  PhotoJournal
//
//  Created by Aaron Cabreja on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class PhotoJournalModel {
    private static let filename = "PhotoJournalList.plist"
    private static var photos = PhotoJournalModel.getPhotoJournal()
    //making the initializer private

    static func getPhotoJournal() -> [Photo]{
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        var photoJournal = [Photo]()
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path){
                do {
                    photoJournal =  try PropertyListDecoder().decode([Photo].self, from: data)
                } catch {
                    print("property list deccoding error: \(error)")
                }
            } else {
                print("getPhotoJournal - data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        return photoJournal
    }
    static func addPhoto(photo: Photo
        ) {
        photos.append(photo)
        save()
    }
    
    static func delete(atIndex index: Int) {
        photos.remove(at: index)
        save()
    }
    
    static func save() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(photos)
            
            try data.write(to: path, options: Data.WritingOptions.atomic)
            
        } catch {
            print("property list encoding error: \(error)")
        }
        print(DataPersistenceManager.filepathToDocumentsDirectory(filename: filename))
    }
    
    static func updateItem(updatedItem: Photo, atIndex index: Int) {
        photos[index] = updatedItem
        save()
    }
}

