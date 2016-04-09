//
//  MultiTypeSpec.swift
//  Vector
//
//  Created by David Lee on 4/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import VectorKit

class CombiningVectorTypesSpec: QuickSpec {
	override func spec() {
		describe("Different vector types") {
			it("can sum together") {
				let point = CGPoint(x: 1, y: -1)
				let size = CGSize(width: 5, height: 10)

				let summedPoint: CGPoint = point + size
				let summedSize: CGSize = point + size

				expect(summedPoint).to(equal(CGPoint(x: 6, y: 9)))
				expect(summedSize).to(equal(CGSize(width: 6, height: 9)))
			}

			it("can take difference") {
				let point = CGPoint(x: 1, y: -1)
				let size = CGSize(width: 5, height: 10)

				let pointDiff: CGPoint = point - size
				let sizeDiff: CGSize = point - size

				expect(pointDiff).to(equal(CGPoint(x: -4, y: -11)))
				expect(sizeDiff).to(equal(CGSize(width: -4, height: -11)))
			}

			it("can piecewise multiply") {
				let point = CGPoint(x: 1, y: -1)
				let size = CGSize(width: 5, height: 10)

				let sizeMult: CGSize = point * size
				let pointMult: CGPoint = point * size

				expect(sizeMult).to(equal(CGSize(width: point.x * size.width, height: point.y * size.height)))
				expect(pointMult).to(equal(CGPoint(x: point.x * size.width, y: point.y * size.height)))
			}

			it("can calculate distance from each other") {
				let point = CGPoint(x: 0, y: 0)
				let size1 = CGSize(width: 0, height: 2)
				let size2 = CGSize(width: 1, height: 0)

				expect(point.distanceTo(size1)).to(equal(2))
				expect(point.distanceTo(size2)).to(equal(1))
			}
		}
	}
}