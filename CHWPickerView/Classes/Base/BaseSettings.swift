//
//  BaseSettings.swift
//  CHWPickerView
//
//  Created by Di on 2019/6/23.
//

import Foundation

open class BaseSettings {
    /// 背景颜色
    open var backgroundColor: UIColor = .white
    /// 文字颜色
    open var textColor: UIColor = .black
    /// 工具栏颜色
    open var toolbarColor: UIColor = UIColor(white: 0.9, alpha: 1)
    /// 工具栏背景图片
    open var toolBarImage: UIImage?
    /// 确认按钮颜色
    open var confirmButtonColor: UIColor = .gray
    /// 确认按钮文字
    open var confirmaButtonText: String = "确定"
    /// 字号
    open var font: UIFont = .systemFont(ofSize: 22)
}
