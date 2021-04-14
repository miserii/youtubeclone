//
//  ViewController.swift
//  youtube
//
//  Created by OsakaMiseri on 2021/03/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    private let cellId = "Cell"
    private var videoItems = [Item]()

    @IBOutlet private weak var videoListCollectionView: UICollectionView! {
        didSet {
            videoListCollectionView.delegate = self
            videoListCollectionView.dataSource = self
            videoListCollectionView.register(UINib(nibName: "VideoListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchListAPI()
    }

    private func fetchListAPI() {
        let urlString = "https://www.googleapis.com/youtube/v3/search?q=bts&key=AIzaSyD_gE7FdzyhVY9jzPIHA3BqivdtltPbDSw&part=snippet"
        let request = AF.request(urlString)

        request.responseJSON { (response) in
            do {
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let video = try decode.decode(VideoModel.self, from: data)
                self.videoItems = video.items
            } catch {
                print("変換に失敗🥺: ", error)
            }
        }
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
