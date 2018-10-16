//
//  TrackCell.swift
//  ReactiveOnlineSearching
//
//  Created by kokoheia on 2018/10/16.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import UIKit


class TrackCell: UITableViewCell {
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    
    func configure(track: Track, downloaded: Bool) {
        titleLabel.text = track.name
        artistLabel.text = track.artist
        
        
        // If the track is already downloaded, enable cell selection and hide the Download button
        selectionStyle = downloaded ? UITableViewCell.SelectionStyle.gray : UITableViewCell.SelectionStyle.none
        downloadButton.isHidden = downloaded
    }
}
