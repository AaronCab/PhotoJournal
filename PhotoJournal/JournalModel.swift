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
    
    //making the initializer private
    private init () {}
    static func savePhotoJournal(photoJournal: Photo){
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(photoJournal)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("poroperty list encoding error")
        }
    }
    static func getPhotoJournal() -> Photo?{
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        var photoJournal: Photo?
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path){
                do {
                    photoJournal =  try PropertyListDecoder().decode(Photo.self, from: data)
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
}

