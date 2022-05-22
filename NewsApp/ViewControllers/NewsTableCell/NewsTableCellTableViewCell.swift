//
//  NewsTableCellTableViewCell.swift
//  NewsApp
//
//  Created by md mozammil on 21/05/22.
//

import UIKit

class NewsTableCellTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var newsImageView: UIImageView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.font = UIFont(name:"Futura-Bold", size: 16.0)
        titleLabel?.textColor = .white
        descriptionLabel?.font = UIFont(name:"fontname", size: 20.0)
        descriptionLabel?.textColor = UIColor.gray
    }

}
