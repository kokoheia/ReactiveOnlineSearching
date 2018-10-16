//
//  ViewController.swift
//  ReactiveOnlineSearching
//
//  Created by Kohei Arai on 2018/10/16.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import ReactiveMapKit
import Result

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: ViewModel!
    
    let trackCell = "trackCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textFieldのテキストからSignalを形成
        let searchStrings = searchBar.reactive.continuousTextValues
        
        //エラーにも対処できるSignal
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
                let string = String(data: data, encoding: .utf8)!
                print(string)
                
                return self.searchResults(from: data)
            }
            .observe(on: UIScheduler())
        
        searchResults.observe { event in
            switch event {
            case let .value(results):
                print("Search results: \(results)")
                
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
            
            if let results = json["results"] as? [Dictionary<String, String>] {
                for dict in results {
                    let track = Track(dict: dict)
                    resultTracks.append(track)
                }
            }

//            print(results.first)
            

//
//            let dict = try JSONDecoder().decode([String: String].self, from: json)
//            print(dict)
//
            
//            return mapArray(json).map({
//                let track = try JSONDecoder().decode(Track.self, from: $0)
//                print(track.artistName)
//            })
//
            
        } catch {
            
        }
        
        return [Track]()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTrackCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trackCell, for: indexPath)
        return cell
    }
    
}

