//
//  CustomCorner.swift
//  PlantApp
//
//  Created by Paul F on 27/02/25.
//

import SwiftUI

// MARK: Custom Corner Path Shape
//Paso 1.11
struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    //Paso 1.12
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
