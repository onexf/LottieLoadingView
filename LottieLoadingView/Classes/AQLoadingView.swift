//
//  AQLoadingView.swift
//  LottieDemo
//
//  Created by AQ on 2019/5/3.
//  Copyright © 2019 AQ. All rights reserved.
//

import UIKit
import Lottie

public class AQLoadingView: UIView {
    
    /// 获取实例
    public static let shared: AQLoadingView = {
        let manger = AQLoadingView()
        return manger
    }()
    
    /// 是否允许点击取消动画
    public var alowCancel: Bool = false
    
    /// 动画文件名，https://lottiefiles.com/recent 这里下载json文件放到项目中，
    public var animationName: String = "935-loading" {
        willSet {
            animationView.animation = Animation.named(newValue)
        }
    }
    
    private let animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.size = CGSize(width: 170, height: 170)
        //        animationView.backgroundColor = .cyan
        return animationView
    }()
    
    private init() {
        super.init(frame: UIApplication.shared.keyWindow?.bounds ?? UIScreen.main.bounds)
        addSubview(animationView)
        animationView.center = center
        animationView.animation = Animation.named(animationName)
//        animationView.animation = Animation.named(animationName, bundle: <#T##Bundle#>, subdirectory: <#T##String?#>, animationCache: <#T##AnimationCacheProvider?#>)
        /// 由于动画在退出前台后会停止，需要监听程序回到前台，执行开始动画
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc private func applicationDidBecomeActive() {
        if self.superview != nil {
            self.animationView.play()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func startLoading() {
        AQLoadingView.shared.addViewToWindow()
        AQLoadingView.shared.animationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
    }
    
    public static func endLoading() {
        AQLoadingView.shared.animationView.stop()
        AQLoadingView.shared.removeFromSuperview()
    }
    
    private func addViewToWindow() {
        if self.superview == nil {
            let frontToBackWindows = UIApplication.shared.windows.reversed()
            for window in frontToBackWindows {
                let windowOnMainScreen: Bool = window.screen == UIScreen.main
                let windowIsVisible = !window.isHidden && window.alpha > 0
                let windowLevelNormal = window.windowLevel == .normal
                if windowOnMainScreen && windowIsVisible && windowLevelNormal {
                    window.addSubview(self)
                    break
                }
            }
            //            let window = UIApplication.shared.delegate?.window as! UIWindow
            //            window.addSubview(self)
            //            print(window)
        } else {
            self.superview?.bringSubviewToFront(self)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.alowCancel {
            AQLoadingView.endLoading()
        }
    }
}
extension UIView {
    
    fileprivate var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    fileprivate var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
    fileprivate var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }
    
    fileprivate var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }
    
    fileprivate var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    fileprivate var right: CGFloat {
        get {
            return self.x + self.w
        } set(value) {
            self.x = value - self.w
        }
    }
    
    fileprivate var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    fileprivate var bottom: CGFloat {
        get {
            return self.y + self.h
        } set(value) {
            self.y = value - self.h
        }
    }
    
    fileprivate var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }
    
    fileprivate var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    fileprivate var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    
    fileprivate var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }
    
}
