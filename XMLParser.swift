//
//  XMLParser.swift
//  StationMilleniumIos
//
//  Created by Romain Caron on 27/06/2016.
//  Copyright © 2016 Station Millenium. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash
import UIKit

class XMLParser: NSObject, NSXMLParserDelegate {
    static let sharedInstance = XMLParser()
    private var titleInfoClass = TitleInfos.sharedInstance
    
    func startCurrentSongParsing() {
        Alamofire.request(.GET, Global.URL.currentSong)
            .responseString { response in
                if ((response.result.value) != nil){
                    let xml = SWXMLHash.parse(response.result.value!)
                    if (xml["androidCurrentSongs"]["currentSong"].element?.attributes["available"] == "true"){
                        let artist = xml["androidCurrentSongs"]["currentSong"]["artist"].element?.text
                        let title = xml["androidCurrentSongs"]["currentSong"]["title"].element?.text
                        if (artist != self.titleInfoClass.Artist){
                            print("Different artist - Update Data")
                        self.titleInfoClass.putCurrentSong(artist!, newTitle: title!)
                        if (xml["androidCurrentSongs"]["currentSong"]["image"].element?.text != nil){
                            let imgUrl = xml["androidCurrentSongs"]["currentSong"]["image"]["path"].element?.text
                            print(imgUrl)
                            let url = Global.URL.currentSongImgFolder+imgUrl!
                            print(url)
                            Alamofire.request(.GET, url).response { (request, response, data, error) in
                                if (response?.statusCode == 200){
                                    let image = UIImage(data: data!, scale:1)
                                    self.titleInfoClass.putImage(image!)
                                }
                            }
                        }else{
                            self.titleInfoClass.putDefaultImage()
                        }
                        self.titleInfoClass.cleanLastSongs()
                        for elem in xml["androidCurrentSongs"]["last5Songs"]["song"] {
                            let artist = elem["artist"].element!.text
                            let title = elem["title"].element!.text
                            self.titleInfoClass.addLastSong(artist!, title: title!)
                        }
                        }
                    }else{
                        self.titleInfoClass.reinitCurrentSong()
                        self.titleInfoClass.putDefaultImage()
                        self.titleInfoClass.cleanLastSongs()
                    }
                }else{
                    self.titleInfoClass.reinitCurrentSong()
                    self.titleInfoClass.putDefaultImage()
                    self.titleInfoClass.cleanLastSongs()
                }
        }
    }
    
    
    
}
