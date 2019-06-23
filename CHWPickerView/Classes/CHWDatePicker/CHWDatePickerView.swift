//
//  CHWDatePickerView.swift
//  CHWPickerView
//
//  Created by Di on 2019/6/23.
//

import UIKit

public class CHWDatePickerView: BaseView {
    private var datePicker = UIDatePicker(frame: .zero)

    private var detailSettings: CHWDatePickerViewSettings = CHWDatePickerViewSettings() {
        didSet {
            datePicker.date = detailSettings.showDate
            datePicker.locale = detailSettings.locale
            datePicker.maximumDate = detailSettings.maxShowDate
            datePicker.minimumDate = detailSettings.minShowDate
            datePicker.datePickerMode = detailSettings.mode
        }
    }

    public override var settings: BaseSettings {
        get {
            return detailSettings
        }

        set {
            super.settings = newValue

            guard let settings = newValue as? CHWDatePickerViewSettings else {
                fatalError("参数必须为CHWPickerViewSettings")
            }

            detailSettings = settings
        }
    }

    private var completion: ((Date)->Void)?
    
    public override var detailView: UIView {
        return datePicker
    }

    public override func hideDone() {
        completion?(datePicker.date)
    }

    public override func setupDetailView() {}

    @discardableResult
    public class func show(in view: UIView,
                           settings: CHWDatePickerViewSettings = CHWDatePickerViewSettings(),
                           completion: @escaping (Date)->Void) -> CHWDatePickerView {
        let picker = CHWDatePickerView(frame: view.bounds)

        picker.settings = settings
        
        view.addSubview(picker)

        picker.show()

        picker.completion = completion

        return picker
    }
}
