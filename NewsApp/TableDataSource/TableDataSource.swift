//
//  TableDataSource.swift
//  NewsApp
//
//  Created by md mozammil on 22/05/22.
//

import Foundation
import UIKit
import WebKit


protocol TableFlowDelegate: AnyObject {
    func tableCellSelectAction(cell: NewsChannelTableViewCell, index: Int, source: String)
    func tableCellSelectAction(cell: NewsTableCellTableViewCell, index: Int, url: String)
    func handlePagination()
}

extension TableFlowDelegate {
    
    func tableCellSelectAction(cell: NewsChannelTableViewCell, index: Int, source: String) {
        //
    }
    func tableCellSelectAction(cell: NewsTableCellTableViewCell, index: Int, url: String) {
        //
    }
}

class TableDataSource: NSObject, UITableViewDelegate, UITableViewDataSource, WKUIDelegate {
    
    weak var delegate: TableFlowDelegate?
    
    var topHeadlineModel: [NewsDataModel] = []
    
    var webView: WKWebView?
    
    
    var isChannelList: Bool = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.topHeadlineModel.count
    }
    
    func handlePagination() {
        print("Hit the api")
        self.delegate?.handlePagination()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.topHeadlineModel.count-1 == indexPath.row {
            handlePagination()
        }
        if self.isChannelList {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsChannelTableViewCell", for: indexPath) as? NewsChannelTableViewCell
            cell?.channelName?.text = self.topHeadlineModel[indexPath.row].sourceName
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableCellTableViewCell", for: indexPath) as? NewsTableCellTableViewCell
            cell?.titleLabel?.text = self.topHeadlineModel[indexPath.row].title
            cell?.descriptionLabel?.text = self.topHeadlineModel[indexPath.row].description
            cell?.newsImageView?.downloaded(from: self.topHeadlineModel[indexPath.row].imageUrl)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isChannelList {
            let cell = tableView.cellForRow(at: indexPath) as? NewsChannelTableViewCell ?? NewsChannelTableViewCell()
            self.delegate?.tableCellSelectAction(cell: cell, index: indexPath.row, source: self.topHeadlineModel[indexPath.row].sourceName)
        } else {
            let cell = tableView.cellForRow(at: indexPath) as? NewsTableCellTableViewCell ?? NewsTableCellTableViewCell()
            self.delegate?.tableCellSelectAction(cell: cell, index: indexPath.row, url: self.topHeadlineModel[indexPath.row].urlToExpand)
        }
    }
    
    
}
