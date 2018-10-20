//
//  Track.swift
//  ReactiveOnlineSearching
//
//  Created by kokoheia on 2018/10/16.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import Foundation
import ReactiveSwift

final class Track: Equatable {
    
    let trackName: String
    let artistName: String
    let index: Int
    
    init(dict: Dictionary<String, Any>) {
        self.trackName = dict["trackName"] as! String
        self.artistName = dict["artistName"] as! String
        self.index = 0
    }
    
    static func == (lhs: Track, rhs: Track) -> Bool {
        if lhs.trackName == rhs.trackName, lhs.artistName == rhs.artistName {
            return true
        } else {
            return false
        }
    }
    
}
