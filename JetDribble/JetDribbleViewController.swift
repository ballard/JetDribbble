//
//  JetDribbleViewController.swift
//  JetDribble
//
//  Created by Ivan Lazarev on 25.08.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import UIKit

class JetDribbleViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewBottomOffset: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var collectionViewController: DribbbleShotsCollectionViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        collectionView?.alwaysBounceVertical = true
        collectionViewController = DribbbleShotsCollectionViewController(collectionView)
        collectionViewController.didRetreiveData = { [weak self] in
            self?.activityIndicator?.startAnimating()
        }
        
        collectionViewController.didFinishRetreiveData = { [weak self] in
            self?.activityIndicator?.stopAnimating()
        }
        
        collectionViewController.updateShotsData()
        collectionViewController.updateNetworkData()
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: Config.Strings.refresher)
        refreshControl.addTarget(collectionViewController, action: #selector(DribbbleShotsCollectionViewController.updateNetworkData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        } else {
            collectionView?.addSubview(refreshControl)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionViewBottomOffset.constant = (self.view.bounds.height - Config.navigationBarHeigth) / 2
    }
}
