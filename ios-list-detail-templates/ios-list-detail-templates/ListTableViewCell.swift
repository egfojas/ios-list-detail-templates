//
//  ListTableViewCell.swift
//  ios-list-detail-templates
//
//  Created by Edgar Allan Fojas on 13/9/19.
//  Copyright © 2019 Edgar Allan Fojas. All rights reserved.
//

import UIKit

protocol ListTableViewCellDelegate: class {
    func listTableViewCell(_ cell: ListTableViewCell, didTapLikeButton: UIButton)
}

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    weak var delegate: ListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton(_:)), for: .touchUpInside)
    }
    
    func bindWith(item: ListItemProtocol) {
        titleLabel.text = item.title
        likeButton.backgroundColor = item.isLiked ? UIColor.red : UIColor.lightGray
    }
    
    @objc private func didTapLikeButton(_ sender: UIButton) {
        delegate?.listTableViewCell(self, didTapLikeButton: sender)
    }
}
