//
//  CHWPickerViewSettings.swift
//  CHWPickerView
//
//  Created by Di on 2019/6/13.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import UIKit

public class CHWPickerViewSettings: BaseSettings {
    /// 每个选择框的高度
    public var pickerComponmentHeight: CGFloat = 44
    /// 选择框文字对齐方式
    public var pickerComponmentTextAlignment: NSTextAlignment = .center
    /// 隐藏行数
    public var showsSelectionIndicator: Bool = false

    public override init() {}
}
