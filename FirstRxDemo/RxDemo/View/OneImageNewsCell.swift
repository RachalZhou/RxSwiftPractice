//
//  OneImageNewsCell.swift
//  RxDemo
//
//  Created by 周日朝 on 2020/6/2.
//  Copyright © 2020 ZRC. All rights reserved.
//

import UIKit

class OneImageNewsCell: UITableViewCell {

    //MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(_ item: NewsItem) {
        let url = URL(string: item.imgsrc.legalUrlString ?? "")
        newsImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        titleLabel.text = item.title
        sourceLabel.text = item.source
    }
    
    //MARK: private method
    private func setupViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(sourceLabel)
        
        newsImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-15)
            make.bottom.equalTo(contentView).offset(-10)
            make.width.equalTo(120.0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(newsImageView.snp.left).offset(-10)
        }
        
        sourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView).offset(-10)
            make.right.equalTo(newsImageView.snp.left).offset(-10)
        }
    }
    
    //MARK: lazy load
    private lazy var newsImageView: UIImageView = {
        let newsImageView = UIImageView(frame: .zero)
        newsImageView.layer.cornerRadius = 5
        newsImageView.layer.masksToBounds = true
        return newsImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        return titleLabel
    }()
    
    private lazy var sourceLabel: UILabel = {
        let sourceLabel = UILabel()
        sourceLabel.textColor = .gray
        sourceLabel.font = UIFont.systemFont(ofSize: 13)
        return sourceLabel
    }()
}
