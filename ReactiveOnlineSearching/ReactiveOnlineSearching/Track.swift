//
//  Track.swift
//  ReactiveOnlineSearching
//
//  Created by kokoheia on 2018/10/16.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import Foundation
import ReactiveSwift

class Track: Decodable {
    

    let trackName: String
    let artistName: String
//    let previewURL: URL
    let index: Int
//    var downloaded = false
    
    init(name: String, artist: String, previewURL: URL, index: Int) {
        self.trackName = name
        self.artistName = artist
//        self.previewURL = previewURL
        self.index = index
    }
    
    init(dict: Dictionary<String, Any>) {
        self.trackName = dict["trackName"] as! String
        self.artistName = dict["artistName"] as! String
        self.index = 0
//        self.previewURL = URL(string: "")!
//        self.index = 0
    }
    
//    static func == (lhs: Track, rhs: Track) -> Bool {
//        if lhs.trackName == rhs.trackName, lhs.artistName == rhs.artistName {
//            return true
//        } else {
//            return false
//        }
//    }
    
//    func generate() -> Generatortype {
//        return self
//    }
//
}

class TrackStore {
    let tracks = MutableProperty([Track]())
    
}
