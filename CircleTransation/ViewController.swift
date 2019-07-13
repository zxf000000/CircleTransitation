//
//  ViewController.swift
//  CircleTransation
//
//  Created by mr.zhou on 2019/7/12.
//  Copyright © 2019 mr.zhou. All rights reserved.
//

import UIKit

let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height

class ViewController: UIViewController, CAAnimationDelegate {

    var centerButton: UIButton!
    var bgView: UIView!
    var maskLayer: CAShapeLayer!
    var animateView: UIView!
    var displaylink: CADisplayLink!
    
    var topPoint: CGPoint!
    var bottomPoint: CGPoint!
    
    var circleCenter: CGPoint!
    var radius: CGFloat!
    
    var leftCenter: CGPoint!
    
    var changed: Bool!
    
    var firstAnim: CABasicAnimation!
    var secondAnim: CABasicAnimation!

    func getPath(for offset: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        var center = CGPoint(x: 150, y: 300)
        var radius: CGFloat = 50
        
        center = CGPoint(x: center.x - offset, y: center.y)
        radius += offset
        
        
        path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        path.addLine(to: CGPoint(x: view.bounds.size.width, y: 300))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: view.bounds.size.height))
        path.addLine(to: CGPoint(x: width, y: view.bounds.size.height))
        path.addLine(to: CGPoint(x: width, y: 300))
        
        return path
    }
    
    func nextAnimation() {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == maskLayer.animation(forKey: "first") {
            let rightPath = UIBezierPath(arcCenter: CGPoint(x: 250 + 50000, y: 300), radius: 50 + 50000, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            maskLayer.removeAllAnimations()
            maskLayer.path = rightPath.cgPath
//
//            let animation = CABasicAnimation(keyPath: "path")
//            animation.toValue = rightPath.cgPath
//            animation.duration = 0.1
//            animation.fillMode = .forwards
//            animation.isRemovedOnCompletion = false
//            animation.delegate = self
//            maskLayer.add(animation, forKey: "second")

            let endPath = UIBezierPath(arcCenter: CGPoint(x: 250, y: 300), radius: 50, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            let animation = CABasicAnimation(keyPath: "path")
            animation.toValue = endPath.cgPath
            animation.duration = 0.6
            animation.fillMode = .forwards
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
            animation.isRemovedOnCompletion = false
            animation.delegate = self
            maskLayer.add(animation, forKey: "t")
            
        }
        
        if anim == maskLayer.animation(forKey: "second") {
            let rightPath = UIBezierPath(arcCenter: CGPoint(x: 250, y: 300), radius: 50, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            let animation = CABasicAnimation(keyPath: "path")
            animation.toValue = rightPath.cgPath
            animation.duration = 0.5
            animation.fillMode = .forwards
            animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
            animation.isRemovedOnCompletion = false
            animation.delegate = self
            maskLayer.add(animation, forKey: "t")
        }
    }
    
    @objc
    func tapView() {
        let endPath = getPath(for: 50000)
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = endPath.cgPath
        animation.duration = 0.5
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        maskLayer.add(animation, forKey: "first")
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        animateView = UIView(frame: view.bounds)
        animateView.backgroundColor = UIColor.red
        view.addSubview(animateView)

        let beginPath = getPath(for: 0)
        
        maskLayer = CAShapeLayer()
        maskLayer.path = beginPath.cgPath
//        maskLayer.strokeColor = UIColor.blue.cgColor
        maskLayer.lineWidth = 2
        maskLayer.fillColor = UIColor.magenta.cgColor
        animateView.layer.addSublayer(maskLayer)
        
        let tap = UIGestureRecognizer(target: self, action: #selector(tapView))
        animateView.addGestureRecognizer(tap)
        
        // todo:
        
//        changed = false
//
//        bgView = UIView(frame: view.bounds)
//        bgView.backgroundColor = UIColor.red
//        view.addSubview(bgView)
//
//        topPoint = CGPoint(x: view.bounds.size.width, y: view.bounds.size.height - 250)
//        bottomPoint = CGPoint(x: view.bounds.size.width, y: view.bounds.size.height - 150)
//
//
//        animateView = UIView()
//        animateView.backgroundColor = UIColor.blue
//        animateView.frame = view.bounds
//
//        view.addSubview(animateView)
//
//        circleCenter = CGPoint(x: view.bounds.size.width/2.0, y: view.bounds.size.height - 200)
//        radius = 50
//        let path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
//
//        maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        animateView.layer.mask = maskLayer
//
//
//
//
        centerButton = UIButton()
        centerButton.setImage(UIImage(named: "arrow"), for: .normal)
        centerButton.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        centerButton.center = CGPoint(x: view.bounds.size.width/2.0, y: view.bounds.size.height - 200)
        centerButton.backgroundColor = UIColor.blue
        centerButton.layer.cornerRadius = 50
        centerButton.addTarget(self, action: #selector(tapCenterButton), for: .touchUpInside)
        view.addSubview(centerButton)
        
        // test:
//        let path = circleBezierPath(for: CGPoint(x: 200, y: 300), angle: Double.pi)
//        maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//
//        maskLayer.strokeColor = UIColor.red.cgColor
//        maskLayer.fillColor = UIColor.clear.cgColor
//        maskLayer.lineWidth = 2
//        maskLayer.strokeEnd = 0.5
//        animateView.layer.addSublayer(maskLayer)
////        animateView.layer.mask = maskLayer
//
//        print(path.currentPoint)
        
    }
    
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//
//        if anim == self.maskLayer.animation(forKey: "first") {
//
//            animateView.backgroundColor = UIColor.red
//            bgView.backgroundColor = UIColor.blue
//
////            maskLayer.path = path.cgPath
//
//            // 开始左侧动画
//            leftCenter = CGPoint(x: view.bounds.size.width / 2.0 - 100 - 50000, y: circleCenter.y)
//
//            let path = UIBezierPath(arcCenter: leftCenter, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
//
//            let animation = CABasicAnimation(keyPath: "path")
//            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//            animation.toValue = path.cgPath
//            animation.duration = 0.01
//            animation.fillMode = .forwards
//            animation.isRemovedOnCompletion = false
//            animation.delegate = self
//
//            maskLayer.add(animation, forKey: "second")
//        } else {
//
//            // 中间动画结束
//
//        }
//
//    }
//
    @objc
    func tapCenterButton() {
        
//        circleCenter = CGPoint(x: circleCenter.x + 50000, y: circleCenter.y)
//        radius += 50000
//        let path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
////        self.maskLayer.path = path.cgPath
//
////        let animation = CAKeyframeAnimation(keyPath: "path")
//
//
//        firstAnim = CABasicAnimation(keyPath: "path")
//        firstAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        firstAnim.toValue = path.cgPath
//        firstAnim.duration = 1
//        firstAnim.fillMode = .forwards
//        firstAnim.isRemovedOnCompletion = false
//        firstAnim.delegate = self
//
//        self.maskLayer.add(firstAnim, forKey: "first")
//
//
//
//
//        return
        
        tapView()
        
        return
        
        displaylink = CADisplayLink(target: self, selector: #selector(beginAnimate))
        displaylink.preferredFramesPerSecond = 200
        displaylink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }

    @objc
    func beginAnimate() {
        
        if changed == true && radius <= 150 {
            displaylink.invalidate()
            
            
            
        }
 
        if radius > 30000 && changed == false {
            changed = true
            
            
            let centerOffsetX = circleCenter.x - view.bounds.size.width / 2.0
            
            let centerX = view.bounds.size.width / 2.0 - 100 - centerOffsetX
            leftCenter = CGPoint(x: centerX, y: circleCenter.y)
            let path = UIBezierPath(arcCenter: leftCenter, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            self.maskLayer.path = path.cgPath
            
            bgView.backgroundColor = UIColor.blue
            animateView.backgroundColor = UIColor.red
            
        }
        
        
        if changed == true {
            var offset: CGFloat = 200
            if radius < 5000 {
                offset = 100
            }
            if radius < 3000 {
                offset = 50
            }
            
            leftCenter = CGPoint(x: leftCenter.x + offset, y: leftCenter.y)
            radius -= offset
            
            let path = UIBezierPath(arcCenter: leftCenter, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            self.maskLayer.path = path.cgPath
            
        } else {
            
            
            var offset: CGFloat = 50
            if radius > 3000 {
                offset = 100
            }
            
            if radius > 5000 {
                offset = 200
            }
            
            circleCenter = CGPoint(x: circleCenter.x + offset, y: circleCenter.y)
            radius += offset
            let path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            self.maskLayer.path = path.cgPath
        }
        
        
    }
    
    
    func circleBezierPath(for center: CGPoint, angle: Double) -> UIBezierPath {
        
        
        let radius: Double = 100
        
        let path = UIBezierPath()

        
        let h: Double = 4/3.0 * (1.0 - cos(angle / 2.0)) / sin(angle / 2.0) * radius
        let pointA = CGPoint(x: Double(center.x) + cos(angle) * radius, y: Double(center.y) - sin(angle) * radius)
        let pointB = CGPoint(x: Double(center.x) + cos(angle) * radius + h * sin(angle), y: Double(center.y) - (sin(angle) * radius - cos(angle) * h))
        let pointC = CGPoint(x: Double(center.x) + radius, y: (Double(center.y) - h))
        let pointD = CGPoint(x: Double(center.x) + radius, y: Double(center.y))
//        path.move(to: CGPoint(x: Double(center.x), y: Double(center.y)))
        path.move(to: pointA)
        path.addCurve(to: pointD, controlPoint1: pointB, controlPoint2: pointC)
        
        
        
        
        return path

    }
    
}

