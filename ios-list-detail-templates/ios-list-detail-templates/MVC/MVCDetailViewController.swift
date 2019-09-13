//
//  MVCDetailViewController.swift
//  ios-list-detail-templates
//
//  Created by Edgar Allan Fojas on 13/9/19.
//  Copyright © 2019 Edgar Allan Fojas. All rights reserved.
//

import UIKit

protocol MVCDetailViewControllerDelegate: class {
    func detailViewController(_ viewController: MVCDetailViewController, didToggleItemLike item: ListItemProtocol)
}

class MVCDetailViewController: DetailViewController {
    var item: ListItemProtocol?
    weak var delegate: MVCDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton(_:)), for: .touchUpInside)
        bindWithItem(self.item)
    }
    
    private func bindWithItem(_ item: ListItemProtocol?) {
        titleLabel.text = item?.title
        likeButton.backgroundColor = (item?.isLiked ?? false) ? UIColor.red : UIColor.lightGray
    }
    
    @objc private func didTapLikeButton(_ sender: UIButton) {
        item?.toggleLikeStatus()
        bindWithItem(item)
        
        guard let item = item else { return }
        delegate?.detailViewController(self, didToggleItemLike: item)
    }
}
