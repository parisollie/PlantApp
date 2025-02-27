//
//  CustomCorner.swift
//  PlantApp
//
//  Created by Paul F on 27/02/25.
//

import SwiftUI

// MARK: Custom Corner Path Shape
struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
