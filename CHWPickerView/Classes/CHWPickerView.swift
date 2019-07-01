//
//  CHWPickerView.swift
//  CHWPickerView
//
//  Created by Di on 2019/6/13.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import UIKit

public class CHWPickerView<DataType>: BaseView {
    private let delegate: CHWPickerViewDelegate<DataType> = CHWPickerViewDelegate(CHWPickerViewSettings())

    public override var detailView: UIView {
        return pickerView
    }

    private var pickerView: UIPickerView = UIPickerView(frame: .zero)

    private var completion: ((DataType?, Int)->Void)?

    private var detailSettings: CHWPickerViewSettings = CHWPickerViewSettings() {
        didSet {
            pickerView.showsSelectionIndicator = detailSettings.showsSelectionIndicator
            delegate.settings = detailSettings
        }
    }

    public override var settings: BaseSettings {
        get {
            return detailSettings
        }
        set {
            super.settings = newValue

            guard let settings = newValue as? CHWPickerViewSettings else {
                fatalError("参数必须为CHWPickerViewSettings")
            }

            detailSettings = settings

        }
    }

    @discardableResult
    public class func show(in view: UIView,
                           type _: DataType.Type = DataType.self,
                           with data: [DataType], selected index: Int = 0,
                           settings: CHWPickerViewSettings = CHWPickerViewSettings(),
                           stringConverter: ((DataType)->String)? = nil,
                           completion: @escaping (DataType?, Int)->Void) -> CHWPickerView {
        let picker = CHWPickerView<DataType>(frame: view.bounds)

        picker.delegate.stringConverter = stringConverter

        picker.settings = settings

        picker.change(dataArray: data, selectedIndex: index)

        view.addSubview(picker)

        picker.show()

        picker.completion = completion

        return picker
    }

    public override func setupDetailView() {
        pickerView.delegate = delegate
        pickerView.dataSource = delegate
    }

    public override func hideDone() {
        var item: DataType?

        if let dataArray = self.delegate.dataArray, dataArray.count > self.delegate.selectedIndex {
            item = dataArray[self.delegate.selectedIndex]
        }

        self.completion?(item, self.delegate.selectedIndex)
    }
}

extension CHWPickerView {


    private func change(dataArray: [DataType], selectedIndex: Int) {

        delegate.dataArray = dataArray
        delegate.selectedIndex = selectedIndex

        pickerView.reloadAllComponents()

        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
    }
}


