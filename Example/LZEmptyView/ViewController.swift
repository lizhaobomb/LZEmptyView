//
//  ViewController.swift
//  LZEmptyView
//
//  Created by lizhaobomb on 05/03/2018.
//  Copyright (c) 2018 lizhaobomb. All rights reserved.
//

import UIKit
import LZEmptyView

class ViewController: UIViewController {
    var data = [0,1,2,3,4,5,6,7,8,9]
    var tableview = UITableView()
    
    override func viewWillLayoutSubviews() {
        tableview.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.emptyViewDelegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController:LZEmptyTableViewDelegate,UITableViewDelegate, UITableViewDataSource {
    func makeEmptyView() -> UIView {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        emptyView.backgroundColor = UIColor.green
        return emptyView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "row \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data.removeAll()
        tableView.lz_reloadData()
    }
}

