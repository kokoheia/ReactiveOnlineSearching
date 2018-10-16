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

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textFieldのテキストからSignalを形成
        let searchStrings = textField.reactive.continuousTextValues
        
        //エラーにも対処できるSignal
        let searchResults = searchStrings
            .flatMap(.latest) { (query: String?) -> SignalProducer<(Data, URLResponse), AnyError> in
                let request = self.makeSearchRequest(escapedQuery: query)
                
                return URLSession.shared.reactive
                    .data(with: request)
                    .retry(upTo: 2)
                    .flatMapError { error in
                        print("Network error occurred: \(error)")
                        return SignalProducer.empty
                }
            }
            .map { (data, response) -> [String] in
                let string = String(data: data, encoding: .utf8)!
                return self.searchResults(fromJSONString: string)
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
    
    private func makeSearchRequest(escapedQuery: String?) -> URLRequest {
        let url = URL(string: "")
        return URLRequest(url: url!)
    }
    
    private func searchResults(fromJSONString: String) -> [String] {
        return [String]()
    }


}

