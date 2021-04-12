//
//  VideoListCollectionViewCell.swift
//  youtube
//
//  Created by OsakaMiseri on 2021/04/08.
//

import UIKit

class VideoListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var channelImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        channelImageView.layer.cornerRadius = 40 / 2
    }

}
