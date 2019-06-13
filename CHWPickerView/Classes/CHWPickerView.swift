//
//  CHWPickerView.swift
//  CHWPickerView
//
//  Created by Di on 2019/6/13.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import UIKit

public class CHWPickerView<DataType>: UIView {
    private class var pickerHeight: CGFloat {
        return CGFloat(260)
    }

    public override var frame: CGRect {
        didSet {
            let height = bounds.height
            let width = bounds.width

            pickerViewContainerView.frame = CGRect(x: 0, y: height - CHWPickerView.pickerHeight, width: width, height: CHWPickerView.pickerHeight)

            pickerViewContainerView.transform = CGAffineTransform(translationX: 0, y: pickerViewContainerView.frame.height)

            toolBarContainerView.frame = CGRect(x: 0, y: 0, width: width, height: 44)

            toolBar.frame = toolBarContainerView.bounds

            pickerView.frame = CGRect(x: 0, y: toolBarContainerView.frame.maxY,
                                      width: width,
                                      height: pickerViewContainerView.bounds.height - toolBarContainerView.frame.maxY)
        }
    }

    private let delegate: CHWPickerViewDelegate<DataType> = CHWPickerViewDelegate(CHWPickerViewSettings())

    private var pickerViewContainerView = UIView(frame: .zero)
    private var toolBarContainerView = UIView(frame: .zero)
    private var toolBar = UIToolbar(frame: .zero)
    private var toolBarConfirmButton: UIBarButtonItem!
    private var pickerView: UIPickerView = UIPickerView(frame: .zero)

    private var completion: ((DataType?, Int)->Void)?

    @discardableResult
    public class func show(in view: UIView,
                           type _: DataType.Type = DataType.self,
                           with data: [DataType], selected index: Int = 0,
                           settings: CHWPickerViewSettings = CHWPickerViewSettings(),
                           stringConverter: ((DataType)->String)? = nil,
                           completion: @escaping (DataType?, Int)->Void) -> CHWPickerView {
        let picker = CHWPickerView<DataType>(frame: view.bounds)

        picker.delegate.stringConverter = stringConverter

        picker.change(settings: settings, dataArray: data, selectedIndex: index)

        view.addSubview(picker)

        picker.hidden(false, callBack: nil)

        picker.completion = completion

        return picker
    }

    public func dismiss(completion: ((DataType?, Int)->Void)? = nil) {
        hidden(true, callBack: completion)
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(quit)))
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(frame: .zero)
        setupView()
    }

    @objc private func confirmAction() {
        hidden(true, callBack: completion)
    }

    @objc private func quit() {
        hidden(true, callBack: nil)
    }
}

extension CHWPickerView {
    private func setupView() {
        pickerView.delegate = delegate
        pickerView.dataSource = delegate

        self.backgroundColor = UIColor(red: 0.412, green: 0.412, blue: 0.412, alpha: 0.7)

        toolBarContainerView.addSubview(toolBar)
        pickerViewContainerView.addSubview(toolBarContainerView)
        pickerViewContainerView.addSubview(pickerView)

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBarConfirmButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(confirmAction))

        toolBar.items = [flexibleSpace, toolBarConfirmButton]

        self.addSubview(pickerViewContainerView)
    }

    private func change(settings: CHWPickerViewSettings, dataArray: [DataType], selectedIndex: Int) {

        delegate.dataArray = dataArray

        pickerViewContainerView.backgroundColor = settings.backgroundColor

        toolBar.backgroundColor = settings.toolbarColor
        toolBar.barTintColor = settings.toolbarColor

        if let image = settings.toolBarImage {
            toolBar.setBackgroundImage(image, forToolbarPosition: .any, barMetrics: .default)
        }

        toolBarConfirmButton.title = settings.confirmaButtonText
        toolBarConfirmButton.tintColor = settings.confirmButtonColor

        pickerView.showsSelectionIndicator = settings.showsSelectionIndicator

        pickerView.reloadAllComponents()

        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
    }

    private func hidden(_ hidden: Bool, callBack: ((DataType?, Int)->Void)?) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            if hidden {
                self.alpha = 0
                self.pickerViewContainerView.transform = CGAffineTransform(translationX: 0, y: self.pickerViewContainerView.frame.height)
            } else {
                self.alpha = 1
                self.pickerViewContainerView.transform = .identity
            }
        }, completion: {
            if hidden && $0 {
                self.removeFromSuperview()

                var item: DataType?

                if let dataArray = self.delegate.dataArray, dataArray.count > self.delegate.selectedIndex {
                    item = dataArray[self.delegate.selectedIndex]
                }

                callBack?(item, self.delegate.selectedIndex)
            }
        })
    }
}


