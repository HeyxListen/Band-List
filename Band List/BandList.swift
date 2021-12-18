//
//  BandList.swift
//  Band List
//
//  Created by csuftitan on 11/5/21.
//

import Foundation

struct Band: Codable {
    var name: String
    var genre: String
    var famousAlbum: String
    //var image: UIImage
    
    static var archiveURL: URL {
           let documentsDirectory = FileManager.default.urls(for:
            .documentDirectory, in: .userDomainMask).first!
           let archiveURL =
            documentsDirectory.appendingPathComponent("emojis")
            .appendingPathExtension("plist")
           return archiveURL
       }
    
    static var sampleBands: [Band] {
    return [
        Band(name: "Taylor Swift", genre: "Alternative/Indie", famousAlbum: "folklore"),
        Band(name: "1975", genre: "Alternative/Indie", famousAlbum: "I like it when you sleep..."),
        Band(name: "Roosevelt", genre: "Dance/Electronic", famousAlbum: "Young Romance"),
        Band(name: "COIN", genre: "Pop", famousAlbum: "Dreamland"),
        Band(name: "Madeon", genre: "Dance/Electronic", famousAlbum: "Good Faith"),
        Band(name: "Kygo", genre: "Dance/Electronic", famousAlbum: "Cloud Nine"),
        Band(name: "LANY", genre: "Alternative Rock", famousAlbum: "Malibu Nights"),
        Band(name: "Coldplay", genre: "Alternative/Indie", famousAlbum: "A Rush of Blood to the Head"),
        Band(name: "Imagine Dragons", genre: "Alternative/Rock", famousAlbum: "Night Visions"),
        Band(name: "The Well Pennies", genre: "Folk", famousAlbum: "Murmurations"),
        ]
    }

    static func saveToFile(bands: [Band]) {
            let propertyListEncoder = PropertyListEncoder()
            let encodedBands = try? propertyListEncoder.encode(bands)
        
            try? encodedBands?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Band]? {
            let propertyListDecoder = PropertyListDecoder()
            guard let retrievedBands = try? Data(contentsOf: archiveURL) else {
                return nil
            }
            let decodedBands = try? propertyListDecoder.decode(Array<Band>.self, from: retrievedBands)
            return decodedBands
    }
}

