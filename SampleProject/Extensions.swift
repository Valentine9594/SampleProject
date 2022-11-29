//
//  Extensions.swift
//  SampleProject
//
//  Created by Neosoft on 28/11/22.
//

import Foundation
import ARKit

extension float4x4 {
    var translation: SIMD3<Float> {
        let translation = self.columns.3
        return SIMD3(translation.x, translation.y, translation.z)
    }
}
