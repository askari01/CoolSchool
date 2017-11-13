//
//  VideoVC.swift
//  CoolSchool
//
//  Created by Syed Askari on 11/13/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit
import YouTubePlayer

class VideoVC: UIViewController {

    @IBOutlet var videoPlayer: YouTubePlayerView!
    
    var videoURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if videoURL == nil {
            videoURL = URL(string: "https://www.youtube.com/watch?v=8ueYlFT0G0c")!
        }
        print (videoURL)
        videoPlayer.loadVideoURL(videoURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
