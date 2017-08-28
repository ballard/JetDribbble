//
//  DribbbleShotsCollectionViewController.swift
//  JetDribble
//
//  Created by Ivan Lazarev on 26.08.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import UIKit

class DribbbleShotsCollectionViewController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var currentPage = 1 {
        didSet {
            print("current page: \(currentPage)")
        }
    }
    
    var shotsData = [Item]() {
        didSet {
            collectionView?.reloadData()
            print("items count: \(ShotsProvider.getShotsCount())")
        }
    }
    
    init(_ collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func updateShotsData(){
        shotsData = ShotsProvider.getShots()
    }
    
    func updateNetworkData(){
        currentPage = 1
        DribbbleAPI.loadDataForPage(currentPage) { [weak self] shots in
            if shots.count > 0 {
                ShotsProvider.saveShots(shots) {
                    self?.updateShotsData()
                }
            }
            DispatchQueue.main.async {
                self?.collectionView?.refreshControl?.endRefreshing()
                self?.collectionView?.setContentOffset(CGPoint.zero, animated: true)
            }
        }
    }
    
    private func loadNextPage() {
        let page = currentPage + 1
        DribbbleAPI.loadDataForPage(page) { [weak self] shots in
            if shots.count > 0 {
                self?.currentPage += 1
                ShotsProvider.saveShots(shots) {
                    DispatchQueue.main.async {
                        self?.updateShotsData()
                    }
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return shotsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Config.cellReuseIdentifier, for: indexPath) as! ShotCollectionViewCell
        // Configure the cell
        cell.item = shotsData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x
        let position = offset / scrollView.frame.width
        let end = scrollView.contentSize.width - scrollView.frame.width
        print("offset: \(offset) end: \(end) position: \(position)")
        let shotsCount = ShotsProvider.getShotsCount()
        
        if offset == end && shotsCount < Config.shotsFetchLimit {
            loadNextPage()
        }
    }

}
