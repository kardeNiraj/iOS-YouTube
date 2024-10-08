//
//  ViewController.swift
//  iOS-YouTube
//
//  Created by apple on 09/08/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let model = Model()
    var videos = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // also set delegate for model
        model.delegate = self
        
        model.getVideos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // confirm a valid selection of video
        guard tableView.indexPathForSelectedRow != nil else {
            return
        }
        
        // get refrence to video that was tapped
        let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
        
        // get refrence to detail view controller
        var detailVC = segue.destination as! DetailViewController
        detailVC.video = selectedVideo
        
        // set video property of detail view controller
    }
    
    // MARK: - ModelDelegate Methods
    func videosFetched(_ videos: [Video]) {
        self.videos = videos
        
        // reload the data to show updated videos
        tableView.reloadData()
    }

    // MARK: - TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEO_CELL_ID, for: indexPath) as! VideoTableViewCell
        
        // configure the cell with data from api
        let video = self.videos[indexPath.row]
        cell.setCell(video)
        
        return cell
    }
    

}

