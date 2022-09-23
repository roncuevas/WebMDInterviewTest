//
//  ImageURLoader.swift
//  WebMDInterviewTest
//
//  Created by user228225 on 9/23/22.
//

import UIKit

// Loads UIImage from URL
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = UIImage(named: "no-results")
                }
            }
        }
    }
}
