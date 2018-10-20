//
//  ViewModel.swift
//  ReactiveOnlineSearching
//
//  Created by kokoheia on 2018/10/16.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import ReactiveMapKit
import Result
import Changeset


final class HomeViewModel {
    
    let trackChangeset = MutableProperty([Changeset<[Track]>.Edit]())
    
    private var tracks: [Track] {
        didSet {
            trackChangeset.value = Changeset.edits(
            from: oldValue,
            to: tracks)
        }
    }
    
    var searchStrings: Signal<String?, NoError>
    
    func getTrackCount() -> Int {
        return tracks.count
    }
    
    func createCellViewModel(for index: Int) -> CellViewModel {
        return CellViewModel(with: tracks[index])
    }
    
    init(searchStrings: Signal<String?, NoError>) {
        self.tracks = []
        self.searchStrings = searchStrings
        
        let searchResults = searchStrings
            .flatMap(.latest) { (query: String?) -> SignalProducer<(Data, URLResponse), AnyError> in
                let request = self.makeSearchRequest(escapedQuery: query)
                return URLSession.shared.reactive
                    .data(with: request!)
                    .retry(upTo: 2)
                    .flatMapError { error in
                        print("Network error occurred: \(error)")
                        return SignalProducer.empty
                }
            }
            .map { (data, response) -> [Track] in
                return self.searchResults(from: data)
            }
            .observe(on: UIScheduler())
        
        searchResults.observe { event in
            switch event {
            case let .value(results):
                print("Search results: \(results)")
                self.tracks = results
            case let .failed(error):
                print("Search error: \(error)")
                
            case .completed, .interrupted:
                break
            }
        }
    }
    
    private func makeSearchRequest(escapedQuery: String?) -> URLRequest? {
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search"), let escapedQuery = escapedQuery {
            urlComponents.query = "media=music&entity=song&term=\(escapedQuery)"
            guard let url = urlComponents.url else { return nil }
            
            return URLRequest(url: url)
        } else {
            return nil
        }
        
    }
    
    private func searchResults(from json: Data) -> [Track] {
        var resultTracks = [Track]()
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {return []}
            
            if let results = json["results"] as? [Dictionary<String, Any>] {
                print(results)
                
                for dict in results {
                    let track = Track(dict: dict)
                    resultTracks.append(track)
                }
                print(resultTracks)
            }
            
        } catch let jsonErr {
            print("Error serializing json: ", jsonErr)
        }
        
        return resultTracks
    }
    
    
}

struct CellViewModel {
    let name: String
    let artist: String
    let index: Int
    
    init(with track: Track) {
        self.name = track.trackName
        self.artist = track.artistName
        self.index = track.index
    }
}
