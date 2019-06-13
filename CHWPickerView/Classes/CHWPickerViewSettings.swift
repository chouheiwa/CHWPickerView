//
//  CHWPickerViewSettings.swift
//  CHWPickerView
//
//  Created by Di on 2019/6/13.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import UIKit

public struct CHWPickerViewSettings {
    /// 背景颜色
    public var backgroundColor: UIColor = .white
    /// 文字颜色
    public var textColor: UIColor = .black
    /// 工具栏颜色
    public var toolbarColor: UIColor = UIColor(white: 0.9, alpha: 1)
    /// 工具栏背景图片
    public var toolBarImage: UIImage?
    /// 确认按钮颜色
    public var confirmButtonColor: UIColor = .gray
    /// 确认按钮文字
    public var confirmaButtonText: String = "确定"
    /// 字号
    public var font: UIFont = .systemFont(ofSize: 22)
    /// 每个选择框的高度
    public var pickerComponmentHeight: CGFloat = 44
    /// 选择框文字对齐方式
    public var pickerComponmentTextAlignment: NSTextAlignment = .center
    /// 隐藏行数
    public var showsSelectionIndicator: Bool = false

    public init() {}
}
