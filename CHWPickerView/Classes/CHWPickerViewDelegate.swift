//
//  CHWPickerViewDelegate.swift
//  CHWPickerView
//
//  Created by Di on 2019/6/13.
//

import Foundation

class CHWPickerViewDelegate<DataType>: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var stringConverter: ((DataType)->String)?

    var settings: CHWPickerViewSettings

    var dataArray: [DataType]?

    var selectedIndex: Int = 0

    init(_ settings: CHWPickerViewSettings) {
        self.settings = settings
        super.init()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var customPickerView: UIView

        var label: UILabel

        if let view = view {
            customPickerView = view

            label = customPickerView.viewWithTag(12350) as! UILabel
        } else {
            customPickerView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width, height: settings.pickerComponmentHeight))

            label = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width, height: settings.pickerComponmentHeight))

            label.tag = 12350

            customPickerView.addSubview(label)
        }

        label.center = CGPoint(x: customPickerView.bounds.width / 2, y: customPickerView.bounds.height / 2)

        label.textAlignment = settings.pickerComponmentTextAlignment
        label.textColor = settings.textColor
        label.font = settings.font

        guard let dataArray = dataArray else { return customPickerView }

        let convertObject = dataArray[row]

        if let stringConverter = stringConverter {
            label.text = stringConverter(convertObject)
        } else {
            guard let text = convertObject as? String else {
                fatalError("Converter is nil, and input array is not String")
            }

            label.text = text
        }

        return customPickerView
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return settings.pickerComponmentHeight
    }
}
