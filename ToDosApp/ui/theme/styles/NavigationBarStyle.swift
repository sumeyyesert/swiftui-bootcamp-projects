//
//  NavigationBarStyle.swift
//  ToDosApp
//
//  Created by Sümeyye Sert on 11.09.2025.
//

import Foundation
import SwiftUI

struct NavigationBarStyle {
    static func setuptNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(AppColors.mainColor)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(AppColors.white),
            .font: UIFont(name: "oswald", size: 22)!
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(AppColors.white),
            .font: UIFont(name: "oswald", size: 22)!
        ]
            
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
