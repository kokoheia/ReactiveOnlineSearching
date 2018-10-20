//
//  TrackCellViewModel.swift
//  ReactiveOnlineSearching
//
//  Created by Kohei Arai on 2018/10/20.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import Foundation

class TrackCellViewModel {
    let name: String
    let artist: String
    let index: Int
    
    init(with track: Track) {
        self.name = track.trackName
        self.artist = track.artistName
        self.index = track.index
    }
}
