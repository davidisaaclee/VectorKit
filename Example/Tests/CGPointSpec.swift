import Quick
import Nimble
import VectorKit

class CGPointSpec: QuickSpec {
	typealias VectorType = CGPoint
	override func spec() {
		describe("CGPoint vectors") {
			let pt = VectorType(collection: [3, 4])

			it("can initialize from collections") {
				expect(VectorType(collection: [1, 2])).to(equal(CGPoint(x: 1, y: 2)))
				expect(VectorType(collection: [-1, -2, 3])).to(equal(CGPoint(x: -1, y: -2)))
			}

			it("adopts CollectionType") {
				expect(pt[0]).to(equal(pt.x))
				expect(pt[1]).to(equal(pt.y))
			}

			it("calculates magnitude") {
				let pt2 = VectorType(collection: [-3, 4])

				expect(pt.magnitude).to(equal(5))
				expect(pt2.magnitude).to(equal(5))

				expect(pt.magnitude).to(equal(pt.length))
				expect(pt2.magnitude).to(equal(pt2.length))
			}

			it("can add") {
				let pt2 = VectorType(collection: [1, -2])
				expect(pt + pt2).to(equal(VectorType(collection: [4, 2])))
			}

			it("can scale") {
				expect(pt * CGFloat(3)).to(equal(VectorType(collection: [9, 12])))
				expect(pt * CGFloat(-1)).to(equal(VectorType(collection: [-3, -4])))

				expect(CGFloat(3) * pt).to(equal(pt * CGFloat(3)))
				expect(CGFloat(-1) * pt).to(equal(pt * CGFloat(-1)))
			}

			it("can piecewise multiply") {
				let pt2 = VectorType(collection: [1, -2])

				expect(pt * pt2).to(equal(VectorType(collection: [pt.x * pt2.x, pt.y * pt2.y])))
				expect(pt2 * pt).to(equal(VectorType(collection: [pt.x * pt2.x, pt.y * pt2.y])))
			}

			it("can get unit vector") {
				let v1 = VectorType(collection: [10, 0])
				let v2 = VectorType(collection: [0, 10])
				expect(v1.unit).to(equal(VectorType(collection: [1, 0])))
				expect(v2.unit).to(equal(VectorType(collection: [0, 1])))

				let u = VectorType(collection: [3, 4]).unit
				expect(u.x).to(beCloseTo(0.6))
				expect(u.y).to(beCloseTo(0.8))

				expect(v1.unit).to(equal(v1.normalized))
				expect(v2.unit).to(equal(v2.normalized))
				expect(u.unit).to(equal(u.normalized))
			}

			it("can negate") {
				expect(pt.negative).to(equal(VectorType(collection: [-pt.x, -pt.y])))
				expect(-pt).to(equal(pt.negative))
			}

			it("can subtract") {
				expect(pt - VectorType(collection: [-2, 4])).to(equal(VectorType(collection: [pt.x + 2, pt.y - 4])))
			}

			it("can equate") {
				let equalPt1 = VectorType(collection: [3, 4])
				let equalPt2 = VectorType(collection: pt)
				let pt2 = VectorType(collection: [1, -2])

				expect(pt == equalPt1).to(beTrue())
				expect(pt == equalPt2).to(beTrue())
				expect(pt == pt2).to(beFalse())
			}

			it("can calculate distances") {
				let p1 = VectorType(collection: [0, 0])
				let p2 = VectorType(collection: [0, 1])
				let p3 = VectorType(collection: [1, 1])

				expect(p1.distanceTo(p2)).to(equal(1))
				expect(p2.distanceTo(p3)).to(equal(1))
				expect(p1.distanceTo(p2)).to(beCloseTo(pow(1.0, 0.5)))
			}
		}
	}
}