//
//  CGSizeSpec.swift
//  Vector
//
//  Created by David Lee on 4/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import VectorKit

class CGSizeSpec: QuickSpec {
	typealias VectorType = CGSize
	override func spec() {
		describe("CGPoint vectors") {
			let pt = VectorType(collection: [3, 4])

			it("can initialize from collections") {
				expect(VectorType(collection: [1, 2])).to(equal(CGSize(width: 1, height: 2)))
				expect(VectorType(collection: [-1, -2, 3])).to(equal(CGSize(width: -1, height: -2)))
			}

			it("adopts CollectionType") {
				expect(pt[0]).to(equal(pt.width))
				expect(pt[1]).to(equal(pt.height))
			}

			it("calculates magnitude") {
				expect(pt.magnitude).to(equal(5))
			}

			it("can add") {
				let pt2 = VectorType(collection: [1, -2])
				expect(pt + pt2).to(equal(VectorType(collection: [4, 2])))
			}

			it("can scale") {
				expect(pt * CGFloat(3)).to(equal(VectorType(collection: [9, 12])))
				expect(pt * CGFloat(-1)).to(equal(VectorType(collection: [-3, -4])))
			}

			it("can get unit vector") {
				expect(VectorType(collection: [10, 0]).unit).to(equal(VectorType(collection: [1, 0])))
				expect(VectorType(collection: [0, 10]).unit).to(equal(VectorType(collection: [0, 1])))

				let u = VectorType(collection: [3, 4]).unit
				expect(u.width).to(beCloseTo(0.6))
				expect(u.height).to(beCloseTo(0.8))
			}

			it("can negate") {
				expect(pt.negative).to(equal(VectorType(collection: [-pt.width, -pt.height])))
			}

			it("can subtract") {
				expect(pt - VectorType(collection: [-2, 4])).to(equal(VectorType(collection: [pt.width + 2, pt.height - 4])))
			}
		}
	}
}