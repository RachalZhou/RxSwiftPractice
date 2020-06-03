//
//  ViewController.swift
//  RxDemo
//
//  Created by 周日朝 on 2020/6/2.
//  Copyright © 2020 ZRC. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxDataSources

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var offset = BehaviorRelay(value: "0")
    private let viewModel = NewsViewModel()
    private var dataSource: RxTableViewSectionedReloadDataSource<NewsSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "新闻列表"
        setupViews()
        
        let output = viewModel.transform(input: offset, dependence: NewsData.shared)
        
        dataSource = RxTableViewSectionedReloadDataSource<NewsSection>(configureCell: { dataSpurce, tableView, indexPath, item in
            
            if item.imgnewextra?.isEmpty ?? true,
                let cell = tableView.dequeueReusableCell(withIdentifier: "OneImageNewsCell", for: indexPath) as? OneImageNewsCell {
                
                cell.setup(item)
                return cell
                
            }else if let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeImageNewsCell", for: indexPath) as? ThreeImageNewsCell {
                
                cell.setup(item)
                return cell
            }
            return UITableViewCell()
        })
        
        output.drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        refreshItem.rx.tap.bind {
            let value = Int(self.offset.value) ?? 0
            self.offset.accept("\(value + 10)")
        }.disposed(by: disposeBag)
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = refreshItem
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: lazy load
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.register(OneImageNewsCell.self, forCellReuseIdentifier: "OneImageNewsCell")
        tableView.register(ThreeImageNewsCell.self, forCellReuseIdentifier: "ThreeImageNewsCell")
        return tableView
    }()
    
    lazy var refreshItem: UIBarButtonItem = {
        let refreshItem = UIBarButtonItem()
        refreshItem.title = "刷新"
        return refreshItem
    }()
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let newsSection = dataSource.sectionModels[indexPath.section]
        let newsItem = newsSection.items[indexPath.row]
        if newsItem.imgnewextra?.isEmpty ?? true {
            return 100.0
        }
        return 180.0
    }
}
