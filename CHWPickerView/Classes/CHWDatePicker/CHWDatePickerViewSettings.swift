//
//  CHWDatePickerViewSettings.swift
//  CHWPickerView
//
//  Created by Di on 2019/6/23.
//

import Foundation

public class CHWDatePickerViewSettings: BaseSettings {
    public var showDate: Date = Date()
    public var locale: Locale = Locale.current
    public var maxShowDate: Date?
    public var minShowDate: Date?
    public var mode: UIDatePicker.Mode = .date

    public override init() {}
}
