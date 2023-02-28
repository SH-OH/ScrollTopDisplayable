//
//  ViewController.swift
//  ScrollTopDisplayable
//
//  Created by SH-OH on 02/27/2023.
//  Copyright (c) 2023 SH-OH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var displayedTopView: DisplayedView!
    
    private lazy var datas: [String] = (0..<200).map(String.init)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayedTopView.configHandler = { [weak self] viewHeight in
            self?.tableView.contentInset.top = viewHeight
            self?.tableView.contentOffset.y = -viewHeight
            if #available(iOS 11.1, *) {
                self?.tableView.verticalScrollIndicatorInsets.top = viewHeight
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        displayedTopView.didScroll(scrollView)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = datas[indexPath.row]
        
        return cell
    }
}
