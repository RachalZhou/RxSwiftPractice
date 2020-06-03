//
//  ThreeImageNewsCell.swift
//  RxDemo
//
//  Created by 周日朝 on 2020/6/2.
//  Copyright © 2020 ZRC. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ThreeImageNewsCell: UITableViewCell {
    
    private let imageWidth = (UIScreen.main.bounds.size.width - 30.0 - 16.0) / 3.0
    
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
        firstImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        
        if let images = item.imgnewextra, images.count == 2 {
            let urls = images.map { $0.imgsrc.legalUrlString }.map { URL(string: $0 ?? "") }
            secondImageView.kf.setImage(with: urls[0], placeholder: UIImage(named: "placeholder"))
            thirdImageView.kf.setImage(with: urls[1], placeholder: UIImage(named: "placeholder"))
        }
        
        titleLabel.text = item.title
        sourceLabel.text = item.source
    }
    
    //MARK: private method
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(secondImageView)
        contentView.addSubview(firstImageView)
        contentView.addSubview(thirdImageView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15.0)
            make.top.equalTo(contentView).offset(10.0)
            make.right.equalTo(contentView).offset(-15.0)
        }
        
        firstImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            make.width.equalTo(imageWidth)
            make.height.equalTo(80.0)
        }
        
        secondImageView.snp.makeConstraints { (make) in
            make.left.equalTo(firstImageView.snp.right).offset(8.0)
            make.centerY.width.height.equalTo(firstImageView)
        }
        
        thirdImageView.snp.makeConstraints { (make) in
            make.left.equalTo(secondImageView.snp.right).offset(8.0)
            make.centerY.width.height.equalTo(firstImageView)
        }
        
        sourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15.0)
            make.bottom.equalTo(contentView).offset(-10.0)
        }
    }
    
    //MARK: lazy load
    private lazy var firstImageView: UIImageView = {
        let firstImageView = UIImageView(frame: .zero)
        firstImageView.layer.cornerRadius = 5
        firstImageView.layer.masksToBounds = true
        return firstImageView
    }()
    
    private lazy var secondImageView: UIImageView = {
        let secondImageView = UIImageView(frame: .zero)
        secondImageView.layer.cornerRadius = 5
        secondImageView.layer.masksToBounds = true
        return secondImageView
    }()
    
    private lazy var thirdImageView: UIImageView = {
        let thirdImageView = UIImageView(frame: .zero)
        thirdImageView.layer.cornerRadius = 5
        thirdImageView.layer.masksToBounds = true
        return thirdImageView
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
