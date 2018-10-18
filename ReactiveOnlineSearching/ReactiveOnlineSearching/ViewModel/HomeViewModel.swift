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


class HomeViewModel {
    
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
    let index: Int
    
//    let previewURL: URL
//    var downloaded = false
    
    init(with track: Track) {
        self.name = track.trackName
        self.artist = track.artistName
        self.index = track.index
//        self.previewURL = track.previewURL
//        self.downloaded = track.downloaded
    }
}
