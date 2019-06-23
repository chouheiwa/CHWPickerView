//
//  BaseView.swift
//  CHWPickerView
//
//  Created by Di on 2019/6/23.
//

import UIKit

open class BaseView: UIView {
    open class var pickerHeight: CGFloat {
        return CGFloat(260)
    }

    var pickerViewContainerView = UIView(frame: .zero)
    var toolBarContainerView = UIView(frame: .zero)
    var toolBar = UIToolbar(frame: .zero)
    var toolBarConfirmButton: UIBarButtonItem!

    open override var frame: CGRect {
        didSet {
            let height = bounds.height
            let width = bounds.width

            pickerViewContainerView.frame = CGRect(x: 0, y: height - type(of: self).pickerHeight, width: width, height: type(of: self).pickerHeight)

            pickerViewContainerView.transform = CGAffineTransform(translationX: 0, y: pickerViewContainerView.frame.height)

            toolBarContainerView.frame = CGRect(x: 0, y: 0, width: width, height: 44)

            toolBar.frame = toolBarContainerView.bounds

            detailView.frame = CGRect(x: 0, y: toolBarContainerView.frame.maxY,
                                      width: width,
                                      height: pickerViewContainerView.bounds.height - toolBarContainerView.frame.maxY)
        }
    }

    open var settings: BaseSettings {
        get {
            fatalError("应该被子类实现")
        }
        set {
            pickerViewContainerView.backgroundColor = settings.backgroundColor

            toolBar.backgroundColor = settings.toolbarColor
            toolBar.barTintColor = settings.toolbarColor

            if let image = settings.toolBarImage {
                toolBar.setBackgroundImage(image, forToolbarPosition: .any, barMetrics: .default)
            }

            toolBarConfirmButton.title = settings.confirmaButtonText
            toolBarConfirmButton.tintColor = settings.confirmButtonColor
        }
    }

    open var detailView: UIView {
        fatalError("代码应被其子类实现")
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(quit)))
        setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func show() {
        hide(false, needCall: false)
    }

    public func hide() {
        hide(true, needCall: false)
    }

    open func hideDone() { fatalError("需要被子类实现") }

    open func setupDetailView() { fatalError("需要被子类实现") }
}

extension BaseView {
    private func hide(_ isHide: Bool, needCall: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            if isHide {
                self.alpha = 0
                self.pickerViewContainerView.transform = CGAffineTransform(translationX: 0, y: self.pickerViewContainerView.frame.height)
            } else {
                self.alpha = 1
                self.pickerViewContainerView.transform = .identity
            }
        }, completion: {
            if isHide && $0 {
                self.removeFromSuperview()

                if needCall {
                    self.hideDone()
                }
            }
        })
    }

    private func setupView() {
        self.backgroundColor = UIColor(red: 0.412, green: 0.412, blue: 0.412, alpha: 0.7)

        toolBarContainerView.addSubview(toolBar)
        pickerViewContainerView.addSubview(toolBarContainerView)
        pickerViewContainerView.addSubview(detailView)

        setupDetailView()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBarConfirmButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(confirmAction))

        toolBar.items = [flexibleSpace, toolBarConfirmButton]

        self.addSubview(pickerViewContainerView)
    }

    @objc private func quit() {hide()}

    @objc private func confirmAction() {hide(true, needCall: true)}
}
