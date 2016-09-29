//
//  PlayerController.swift
//  Station_Millenium_Sur_iOS
//
//  Created by Romain Caron on 09/09/2016.
//  Copyright © 2016 Station Millenium. All rights reserved.
//

import Foundation
import UIKit

class PlayerController: UIViewController {
    private var player:RadioPlayer = RadioPlayer.sharedInstance
    private var titleInfos: TitleInfos = TitleInfos.sharedInstance
    private var timer: NSTimer?
    
    @IBOutlet weak var artistText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var waitView: UIActivityIndicatorView!
    @IBOutlet weak var fiveLastSongButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var currentArtistImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waitView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        waitView.color = UIColor .whiteColor()
        fiveLastSongButton.layer.cornerRadius = 5
        fiveLastSongButton.layer.borderWidth = 1
        fiveLastSongButton.layer.borderColor = UIColor(red:0.00, green:0.46, blue:1.00, alpha:1.0).CGColor
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        player.addObserver(self, forKeyPath: "isPlaying", options: .New, context: nil)
        titleInfos.addObserver(self, forKeyPath: "Title", options: .New, context: nil)
        titleInfos.addObserver(self, forKeyPath: "currentArtistImg", options: .New, context: nil)
        waitView.hidden = true
        XMLParser.sharedInstance.startCurrentSongParsing()
        timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: XMLParser(), selector: #selector(XMLParser.startCurrentSongParsing), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        titleInfos.reinitCurrentSong()
        titleInfos.putDefaultImage()
        titleInfos.cleanLastSongs()
        print("viewWillDisappear")
        player.removeObserver(self, forKeyPath: "isPlaying")
        titleInfos.removeObserver(self, forKeyPath: "Title")
        titleInfos.removeObserver(self, forKeyPath: "currentArtistImg")
        timer?.invalidate()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggle() {
        if RadioPlayer.sharedInstance.currentlyPlaying() {
            pauseRadio()
        } else {
            playRadio()
            waitView.hidden = false;
            waitView.startAnimating()
            playButton.hidden = true;
        }
    }
    
    func playRadio() {
        RadioPlayer.sharedInstance.play()
    }
    
    func pauseRadio() {
        RadioPlayer.sharedInstance.pause()
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        switch keyPath! {
        case "isPlaying":
            let result = player.currentlyPlaying()
            if (result){
                print("Debut playing")
                waitView.hidden = true
                waitView.stopAnimating()
                playButton.hidden = false
                playButton.setImage(UIImage(named: "pause"), forState: UIControlState())
            }else{
                playButton.setImage(UIImage(named: "Player"), forState: UIControlState())
            }
            break
        case "Title":
            print("Title")
            artistText.text = titleInfos.getCurrentArtist()
            titleText.text = titleInfos.getCurrentTitle()
            break
        case "currentArtistImg":
            currentArtistImageView.image = titleInfos.currentArtistImg
            break
        default:
            print("default")
            break
        }
    }
    
    @IBAction func pressPlayButton(sender: UIButton) {
        toggle();
    }
    
    @IBAction func press5lastSongs(sender: UIButton) {
        var msg = ""
        if (titleInfos.lastTitles.count == 5) {
            for index in 0...4{
                msg += titleInfos.lastArtists[index]+" - "+titleInfos.lastTitles[index]
                if (index<4) {
                    msg+="\n"
                }
            }
        }else{
            msg = NSLocalizedString("fiveSongsErrorMessage", comment: "")
        }
        
        let alertController = UIAlertController(title: NSLocalizedString("5 derniers titres", comment: ""), message:
            msg, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    

}
