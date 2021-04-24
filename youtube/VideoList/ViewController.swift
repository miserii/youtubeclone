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
        let urlString = "https://www.googleapis.com/youtube/v3/search?q=bigbang&key=AIzaSyD_gE7FdzyhVY9jzPIHA3BqivdtltPbDSw&part=snippet"
        let request = AF.request(urlString)

        request.responseJSON { (response) in
            do {
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let video = try decode.decode(Video.self, from: data)
                self.videoItems = video.items

                let id = self.videoItems[0].snippet.channelId
                self.fetchYoutubeChannelInfo(id: id)
            } catch {
                print("変換に失敗🥺: ", error)
            }
        }
    }

    private func fetchYoutubeChannelInfo(id: String) {
        let urlString = "https://www.googleapis.com/youtube/v3/channels?key=AIzaSyB0mZ_WfQqmN7GNuxiGBjlMKS-ZpRGEd2E&part=snippet&id=\(id)"

        let request = AF.request(urlString)

        request.responseJSON { (response) in
            do {
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let channel = try decode.decode(Channel.self, from: data)
                self.videoItems.forEach { (item) in
                    item.channel = channel
                }

                self.videoListCollectionView.reloadData()

            } catch {
                print("変換に失敗しました。: ", error)
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

        return videoItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videoListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoListCollectionViewCell
        cell.videoItem = videoItems[indexPath.row]

        return cell
    }

}
