//
//  TableView+LZEmptyView.swift
//  SwiftEmptyViewDemo
//
//  Created by 9fbank-lizhao on 2018/5/3.
//  Copyright © 2018年 9fbank-lizhao. All rights reserved.
//
import UIKit
import Foundation

public protocol LZEmptyTableViewDelegate:NSObjectProtocol {
    func makeEmptyView() -> UIView
}

private var kEmptyDelegateKey: Void?
private var kEmptyViewKey: Void?

public extension UITableView {
    var emptyView: UIView? {
        get {
            return objc_getAssociatedObject(self, &kEmptyViewKey) as? UIView
        }
        set (newValue){
            if let newValue = newValue {
                objc_setAssociatedObject(self, &kEmptyViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
   public var emptyViewDelegate:LZEmptyTableViewDelegate? {
        get {
            return objc_getAssociatedObject(self,&kEmptyDelegateKey) as? LZEmptyTableViewDelegate
        }
        set (newValue) {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &kEmptyDelegateKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
    
    
   public func lz_reloadData(){
        self.reloadData()
        var isEmpty = true
        
        let src = self.dataSource
        
        var sections = 1
    
        if (src?.responds(to: #selector(getter: UITableView.numberOfSections)))! {
            sections = (src?.numberOfSections!(in: self))!
        }
        
        for i in 0..<sections {
            let rows = src?.tableView(self, numberOfRowsInSection: i)
            if rows! > 0 {
                isEmpty = false
                break
            }
        }
        
        if isEmpty {
            self.emptyView?.removeFromSuperview()
            self.emptyView = nil
            if let emptyViewDelegate = self.emptyViewDelegate {
                self.emptyView = emptyViewDelegate.makeEmptyView()
            } else {
                assert(false, "必须实现EmptyView的的协议")
            }
            if (self.emptyView?.frame.isEmpty)! {
                self.emptyView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            }
            self.addSubview(self.emptyView!)
            self.isScrollEnabled = false
        } else {
            self.emptyView?.removeFromSuperview()
            self.emptyView = nil
            self.isScrollEnabled = true
        }
        
    }
}
