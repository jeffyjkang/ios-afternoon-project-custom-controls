//
//  CustomControl.swift
//  CustomControls
//
//  Created by Jeff Kang on 11/23/20.
//

import UIKit

class CustomControl: UIControl {
    
    var oldValue: Int = 1
    var value: Int = 1
    let componentDimension: CGFloat = 40.0
    let componentCount: Int = 5
    let componentActiveColor: UIColor = UIColor.black
    let componentInactiveColor: UIColor = UIColor.gray
    
    var labels: [UILabel] = []
    
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setup()
    }
    
    private func setup() {
        for i in 1...componentCount {
            let label = UILabel(frame: CGRect(x: (8 * CGFloat(i)) + (componentDimension * CGFloat(i - 1)), y: 0.0, width: componentDimension, height: componentDimension))
            label.tag = i
            label.font = UIFont.boldSystemFont(ofSize: 32.0)
            label.text = "✶"
            label.textAlignment = .center
            label.textColor = (i == 1) ? componentActiveColor : componentInactiveColor
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    override var intrinsicContentSize: CGSize {
      let componentsWidth = CGFloat(componentCount) * componentDimension
      let componentsSpacing = CGFloat(componentCount + 1) * 8.0
      let width = componentsWidth + componentsSpacing
      return CGSize(width: width, height: componentDimension)
    }
    
    // MARK: Touch Tracking
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch)
        sendActions(for: [.touchDown, .valueChanged])
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: .touchDragOutside)
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer {
            super.endTracking(touch, with: event)
        }
        guard let touch = touch else { return }
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: .touchUpOutside)
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
    
    func updateValue(at touch: UITouch) {
        let touchPoint = touch.location(in: self)
        for label in labels {
            if label.frame.contains(touchPoint) {
                value = label.tag
                if value != oldValue {
                    oldValue = value
                    label.performFlare()
                    sendActions(for: .valueChanged)
                }
            }
            if label.tag <= value {
                label.textColor = componentActiveColor
            } else {
                label.textColor = componentInactiveColor
            }
        }
    }
    
}

extension UIView {
  // "Flare view" animation sequence
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}
