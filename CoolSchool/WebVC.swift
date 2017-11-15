//
//  WebVC.swift
//  CoolSchool
//
//  Created by Syed Askari on 11/13/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var mainMenuButton: UIButton!
    
    var myProgressView: Float = 0.0
    var theBool: Bool!
    var myTimer: Timer!

    var videoURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.delegate = self
        if videoURL == nil {
            videoURL = URL(string: "https://www.youtube.com/watch?v=8ueYlFT0G0c")!
        }
        
        // view tweak
        mainMenuButton.layer.cornerRadius = 15
        webView.clipsToBounds = true
        webView.backgroundColor = UIColor.black
        webView.isOpaque = false
        webView.layer.cornerRadius = 25
        
        // request
        let request = URLRequest(url: videoURL!)
        webView.loadRequest(request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.loading.isHidden = false
        funcToCallWhenStartLoadingYourWebview()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        funcToCallCalledWhenUIWebViewFinishesLoading()
        self.loading.stopAnimating()
        self.loading.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func funcToCallWhenStartLoadingYourWebview() {
        self.myProgressView = 0.0
        self.theBool = false
        self.myTimer = Timer.scheduledTimer(timeInterval: 0.01667,
                                            target: self,
                                            selector: "timerCallback",
                                            userInfo: nil,
                                            repeats: true)
    }
    
    func funcToCallCalledWhenUIWebViewFinishesLoading() {
        self.theBool = true
    }
    
    func timerCallback() {
        print (self.myProgressView)
        if self.theBool {
            if self.myProgressView >= 1 {
                self.loading.stopAnimating()
                self.myTimer.invalidate()
            } else {
                self.myProgressView += 0.1
            }
        } else {
            self.myProgressView += 0.05
            if self.myProgressView >= 0.95 {
                self.myProgressView = 0.95
            }
        }
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
