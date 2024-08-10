//
//  VideoTableViewCell.swift
//  iOS-YouTube
//
//  Created by apple on 10/08/24.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var video: Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v: Video) {
        self.video = v
        
        // make sure video is set
        guard video != nil else {
            return
        }
        
        // set title
        self.titleLabel.text = video?.title
        
        // set data
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = df.string(from: video!.published)
        
        if let cachedData = CacheManager.getImageCache(self.video!.thumbnail) {
            self.thumbnailImageView.image = UIImage(data: cachedData)
            return
        }
        
        // download thumbnail
        guard self.video?.thumbnail != "" else {
            return
        }
        
        let url = URL(string: self.video!.thumbnail)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error != nil || data == nil {
                if let err = error {
                    print("Exit with error: \(err)")
                } else {
                    print("No data recieved")
                }
                return
            }
            
            // cache image
            CacheManager.setImageCache(url!.absoluteString, image: data)
            
            // check if the url for downloaded image is present for the current tableVirwCell, as the cells are recycled for items in view, probablity is that the cell got outside of the view and the downloaded image is no longer required for the time being
            if url?.absoluteString != self.video?.thumbnail {
                // this means that the item has slided out of view
                return
            }
            
            let image = UIImage(data: data!)
            
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
        
        dataTask.resume()
    }

}
