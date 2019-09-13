//
//  MVCListViewController.swift
//  ios-list-detail-templates
//
//  Created by Edgar Allan Fojas on 13/9/19.
//  Copyright © 2019 Edgar Allan Fojas. All rights reserved.
//

import UIKit

class MVCListViewController: ListViewController {
    var items: [ListItemProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableHeaderView = UIView(frame: .zero)
        
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListTableViewCell")
        
        items = [ListItem(id: "1", image: nil, title: "1", isLiked: true),
                 ListItem(id: "2", image: nil, title: "2", isLiked: true),
                 ListItem(id: "3", image: nil, title: "3", isLiked: true),
                 ListItem(id: "4", image: nil, title: "4", isLiked: true),
                 ListItem(id: "5", image: nil, title: "5", isLiked: true)]
    }
    
    func gotoItemDetails(_ item: ListItemProtocol) {
        let detailViewController = MVCDetailViewController(nibName: "DetailViewController", bundle: Bundle.main)
        detailViewController.item = item
        detailViewController.delegate = self
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MVCListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.bindWith(item: items[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}

extension MVCListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        gotoItemDetails(item)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MVCListViewController: ListTableViewCellDelegate {
    func listTableViewCell(_ cell: ListTableViewCell, didTapLikeButton: UIButton) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        var item = items[indexPath.row]
        item.toggleLikeStatus()
        items[indexPath.row] = item
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension MVCListViewController: MVCDetailViewControllerDelegate {
    func detailViewController(_ viewController: MVCDetailViewController, didToggleItemLike item: ListItemProtocol) {
        guard let index = items.firstIndex(where: { $0.id == item.id}) else { return }
        items[index] = item
        
        tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
    }
}

