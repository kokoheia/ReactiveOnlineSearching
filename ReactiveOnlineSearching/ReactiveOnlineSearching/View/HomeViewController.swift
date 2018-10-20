//
//  HomeViewController.swift
//  ReactiveOnlineSearching
//
//  Created by Kohei Arai on 2018/10/16.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
//import ReactiveMapKit
//import Result

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: HomeViewModel!
    private let trackCell = "trackCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        //searchBarのcontinuousTextValuesをSignal化
        let searchStrings = searchBar.reactive.continuousTextValues
        //そのsignalをもとにViewModelのインスタンスを作る
        //※viewModel中で、searchBarのtextを常にObserveしてviewModelを更新している
        self.viewModel = HomeViewModel(searchStrings: searchStrings)
        
        //searchBarのtextはviewModelのsearchStringsを参照
        if let navItem = self.navigationBar.topItem {
            navItem.reactive.title <~ viewModel.searchStrings
        }
        
        //viewModelのtracksが変わる度にtableViewをupdateする。
        self.viewModel.trackChangeset.producer.startWithValues { edits in
            self.tableView.update(with: edits)
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getTrackCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trackCell, for: indexPath) as! TrackCell
        cell.viewModel = self.viewModel?.createCellViewModel(for: indexPath.row)
        return cell
    }
    
}

