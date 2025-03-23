import Foundation

import struct SwiftUI.Color
import class UIKit.UIColor

extension UIColor {
  internal convenience init(light: UIColor, dark: UIColor) {
    self.init { $0.userInterfaceStyle == .dark ? dark : light }
  }
}

extension Color {
  internal init(light: Color, dark: Color) {
    self.init(_uiColor: UIColor.init(light: UIColor(light), dark: UIColor(dark)))
  }
}

extension Color {
    internal static let toastBackground: Color = Color(
        light: Color(_uiColor: UIColor(hex: "#2F3036FF") ?? UIColor.white),
        dark: Color(_uiColor: UIColor(hex: "#E2E2E9FF") ?? UIColor(white: 0.12, alpha: 1.0))
    )
    
    internal static let toastTextColor: Color = Color(
        light: Color(_uiColor: UIColor(hex: "#F0F0F7FF") ?? UIColor.white),
        dark: Color(_uiColor: UIColor(hex: "#2F3036FF") ?? UIColor(white: 0.12, alpha: 1.0))
    )
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
