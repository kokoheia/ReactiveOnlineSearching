//
//  ViewModel.swift
//  ReactiveOnlineSearching
//
//  Created by kokoheia on 2018/10/16.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import Foundation
import ReactiveSwift
//import Changeset


class ViewModel {
    
//    let trackChangeset = MutableProperty([Changeset<[Track]>.Edit]())
    
    private var tracks: [Track]
    
//    {
////        didSet {
////            trackChangeset.value = Changeset.edits(
////            from: oldValue,
////            to: tracks)
////        }
//    }
    
    func getTrackCount() -> Int {
        return tracks.count
    }
    
    func createCellViewModel(for index: Int) -> CellViewModel {
        return CellViewModel(with: tracks[index])
    }
    
    init(tracks: [Track]) {
        self.tracks = tracks
    }
    
}

struct CellViewModel {
    let name: String
    let artist: String
//    let previewURL: URL
    let index: Int
//    var downloaded = false
    
    init(with track: Track) {
        self.name = track.trackName
        self.artist = track.artistName
//        self.previewURL = track.previewURL
        self.index = track.index
//        self.downloaded = track.downloaded
    }
}
