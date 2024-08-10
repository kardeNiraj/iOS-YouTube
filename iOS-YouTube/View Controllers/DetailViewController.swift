//
//  DetailViewController.swift
//  iOS-YouTube
//
//  Created by apple on 10/08/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var videoWebView: WKWebView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // clear fields initially to get a clean slate
        titleLabel.text = ""
        dateLabel.text = ""
        descriptionTextView.text = ""
        
        // check if video is present
        guard video != nil else {
            return
        }
        
        // create embed url
        let embedUrl = Constants.YT_EMBED_URL + video!.videoId
        
        // set up the webView
        let url = URL(string: embedUrl)
        let request = URLRequest(url: url!)
        videoWebView.load(request)
        
        // set the title
        titleLabel.text = video!.title
        
        // set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = df.string(from: video!.published)
        
        // set the description
        descriptionTextView.text = video!.description
    }
}
