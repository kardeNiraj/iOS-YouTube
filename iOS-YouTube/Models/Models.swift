//
//  Models.swift
//  iOS-YouTube
//
//  Created by apple on 10/08/24.
//

import Foundation

protocol ModelDelegate {
    func videosFetched(_ videos: [Video])
}

class Models {
    var delegate: ModelDelegate?
    
    func getVideos() {
        // get a URL object
        let url = URL(string: Constants.URL)
        
        guard url != nil else {
            return
        }
        
        // get a URLSession
        let session = URLSession.shared
        
        // get data task from the URLSession
        let dataTask = session.dataTask(with: url!) { data, response, error in
            // check for errors
            if error != nil || data == nil {
                print("Exit with error: \(error!)")
            }
            
            // parsing data to video objects
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                
                // call the videosFetched method to pass the videos
                if response.items != nil {
                    DispatchQueue.main.async {
                        self.delegate?.videosFetched(response.items!)
                    }
                }
                
                // dump(response)
            } catch {
                print("Error while decoding the response: \(error)")
            }
        }
        
        // kick of the task
        dataTask.resume()
    }
}
