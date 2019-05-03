//
//  ViewController.swift
//  LottieDemo
//
//  Created by AQ on 2019/5/3.
//  Copyright © 2019 AQ. All rights reserved.
//

import UIKit
import LottieLoadingView

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 允许点击屏幕结束动画，默认不允许
        AQLoadingView.shared.alowCancel = true
        
        /// App第一个页面加载出来之前makeKeyAndVisible没有调用，获取不到window，无法添加动画到window上，添加一个延时
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.loadData()
        }
    }

    func loadData() {
        
        AQLoadingView.startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            AQLoadingView.endLoading()
        }
    }
    
    @IBAction func show(_ sender: UIButton) {
        AQLoadingView.startLoading()
    }
    
    @IBAction func hide(_ sender: UIButton) {
    }
    
    
    @IBAction func selectAnimation2(_ sender: UIButton) {
        AQLoadingView.shared.animationName = "9squares-AlBoardman"
    }
    @IBAction func selectAnimation1(_ sender: UIButton) {
        AQLoadingView.shared.animationName = "935-loading"
    }
}

