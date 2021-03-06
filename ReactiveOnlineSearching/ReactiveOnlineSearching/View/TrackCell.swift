//
//  TrackCell.swift
//  ReactiveOnlineSearching
//
//  Created by kokoheia on 2018/10/16.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import UIKit

final class TrackCell: UITableViewCell {
    
    var viewModel: TrackCellViewModel! {
        didSet {
            artistLabel.text = viewModel.artist
            titleLabel.text = viewModel.name
        }
    }
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
}
