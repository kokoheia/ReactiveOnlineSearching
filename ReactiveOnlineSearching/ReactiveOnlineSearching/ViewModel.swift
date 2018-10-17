//
//  ViewModel.swift
//  ReactiveOnlineSearching
//
//  Created by kokoheia on 2018/10/16.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import Foundation
import ReactiveSwift

class ViewModel {
    private var tracks = [Track]()
    
    func getTrackCount() -> Int {
        return tracks.count
    }
    
    func createCellViewModel(for index: Int) -> CellViewModel {
        return CellViewModel(with: tracks[index])
    }
    
}

struct CellViewModel {
    let name: String
    let artist: String
//    let previewURL: URL
//    let index: Int
//    var downloaded = false
    
    init(with track: Track) {
        self.name = track.trackName
        self.artist = track.artistName
//        self.previewURL = track.previewURL
//        self.index = track.index
//        self.downloaded = track.downloaded
    }
}
