//
//  CacheManager.swift
//  iOS-YouTube
//
//  Created by apple on 10/08/24.
//

import Foundation

class CacheManager {
    static var cache = [String:Data]()
    static func setImageCache(_ url: String, image: Data?) {
        cache[url] = image
    }
    
    static func getImageCache(_ url: String) -> Data? {
        return cache[url]
    }
}
