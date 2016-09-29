//
//  TitleInfos.swift
//  StationMilleniumIos
//
//  Created by Romain Caron on 27/06/2016.
//  Copyright © 2016 Station Millenium. All rights reserved.
//

import Foundation
import UIKit

class TitleInfos: NSObject {
    static let sharedInstance = TitleInfos()
    dynamic var Artist: String = NSLocalizedString("default_artist", comment: "")
    dynamic var Title: String = NSLocalizedString("default_title", comment: "")
    dynamic var lastArtists: Array = [String]()
    dynamic var lastTitles: Array = [String]()
    dynamic var currentArtistImg: UIImage = UIImage(named: "DefaultLogo")!
    
    func reinitCurrentSong() {
        Artist = NSLocalizedString("default_artist", comment: "")
        Title = NSLocalizedString("default_title", comment: "")
    }
    
    func putCurrentSong(newArtist: String, newTitle: String) {
        Artist = newArtist
        Title = newTitle
    }
    
    func getCurrentArtist() -> String {
        return Artist
    }
    
    func getCurrentTitle() -> String {
        return Title
    }
    
    func cleanLastSongs() {
        lastTitles.removeAll()
        lastArtists.removeAll()
    }
    
    func addLastSong(artist: String,title: String) {
        lastArtists.append(artist)
        lastTitles.append(title)
    }
    
    func putDefaultImage(){
        currentArtistImg = UIImage(named: "DefaultLogo")!
    }
    
    func putImage(image: UIImage) {
        currentArtistImg = image
    }
    
}
