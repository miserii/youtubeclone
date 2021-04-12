//
//  ViewController.swift
//  youtube
//
//  Created by OsakaMiseri on 2021/03/27.
//

import UIKit

class ViewController: UIViewController {

    private let cellId = "Cell"

    @IBOutlet private weak var videoListCollectionView: UICollectionView! {
        didSet {
            videoListCollectionView.delegate = self
            videoListCollectionView.dataSource = self
            videoListCollectionView.register(UINib(nibName: "VideoListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width

        return .init(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videoListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoListCollectionViewCell
        // cell.backgroundColor = .green

        return cell
    }


}
