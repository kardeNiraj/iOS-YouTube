//
//  Model.swift
//  iOS-YouTube
//
//  Created by apple on 10/08/24.
//

import Foundation

protocol ModelDelegate {
    func videosFetched(_ videos: [Video])
}

class Model {
    var items: [Video]?
    var delegate: ModelDelegate?
    
    func getVideos() {
        // get url
        let url = URL(string: Constants.URL)
        
        // get URLSeesion
        let session = URLSession.shared
        
        // get dataTask
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error != nil || data == nil {
                if let err = error {
                    print("error in fetching data: \(err)")
                } else {
                    print("No data recieved")
                }
                return
            }
            
            // parse data
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                
                DispatchQueue.main.async {
                    self.delegate?.videosFetched(response.items!)
                }
            } catch {
                print("Error while decoding the response: \(error)")
                //
            }
        }
        
        // kick off urlsession
        dataTask.resume()
    }
}
