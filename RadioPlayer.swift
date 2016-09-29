//
//  RadioPlayer.swift
//  Station_Millenium_Sur_iOS
//
//  Created by Romain Caron on 08/09/2016.
//  Copyright © 2016 Station Millenium. All rights reserved.
//

import Foundation
import AVFoundation

class RadioPlayer: NSObject {
    static let sharedInstance = RadioPlayer()
    private var player:AVPlayer?
    dynamic var isPlaying = false
    
    func play() {
        player = AVPlayer(URL: NSURL(string: Global.URL.stream)!)
        self.startObserve(player!)
        player!.play()
        
        NSNotificationCenter.defaultCenter().addObserverForName(
            AVPlayerItemFailedToPlayToEndTimeNotification,
            object: nil,
            queue: nil,
            usingBlock: { notification in
                print("Error during playing")
                RadioPlayer.sharedInstance.isPlaying = false
        })
    }
    
    func startObserve(myPlayer: AVPlayer) {
        let options = NSKeyValueObservingOptions([.New, .Old])
        myPlayer.currentItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: options, context: nil)
        myPlayer.currentItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: options, context: nil)
        myPlayer.currentItem?.addObserver(self, forKeyPath: "status", options: .New, context: nil)
    }
    
    func pause() {
        player!.pause()
        player!.currentItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        player!.currentItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        player!.currentItem?.removeObserver(self, forKeyPath: "status")
        NSNotificationCenter.defaultCenter().removeObserver(AVPlayerItemFailedToPlayToEndTimeNotification)
        player = nil
        isPlaying = false
    }
    
    func toggle() {
        if isPlaying == true {
            pause()
        } else {
            play()
        }
    }
    
    func currentlyPlaying() -> Bool {
        return isPlaying
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        switch keyPath! {
        case "playbackLikelyToKeepUp":
            print(change)
            print("playbackLikelyToKeepUp")
            print(player?.currentItem?.status.hashValue)
            isPlaying = true
        case "status":
            print(change)
            if (player?.currentItem?.status.hashValue == 2){
                isPlaying = false
            }
        default:
            print("default")
        }
    }

    
    //TODO : prevoir lorsqu'il y a un appel
    
}
