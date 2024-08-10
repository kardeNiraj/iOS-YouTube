//
//  Constants.swift
//  iOS-YouTube
//
//  Created by apple on 09/08/24.
//

import Foundation

class Constants {
    static var API_KEY = ProcessInfo.processInfo.environment["API_KEY"] ?? "AIzaSyCZbuRr3QHIyDiQF2mJQyTmMmc3rptNbuY"
    static var PLAYLIST_ID = ProcessInfo.processInfo.environment["PLAYLIST_ID"] ?? "UULFaPwrWiaK0VR3RNAC36Qt6A"
    static var URL = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
    static var VIDEO_CELL_ID = "VideoCell"
    static var YT_EMBED_URL = "https://www.youtube.com/embed/"
}
