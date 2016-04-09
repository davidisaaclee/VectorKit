import Quick
import Nimble
import VectorKit

class CustomVector2TypeSpec: QuickSpec {
	typealias VectorType = CustomVector2
	override func spec() {
		describe("Custom vectors") {
			let pt = VectorType(collection: [3, 4])

			it("can initialize from collections") {
				expect(CustomVector2(x: 0, y: 1)).to(equal(CustomVector2(x: 0, y: 1)))

				expect(VectorType(collection: [1, 2])).to(equal(CustomVector2(x: 1, y: 2)))
				expect(VectorType(collection: [-1, -2, 3])).to(equal(CustomVector2(x: -1, y: -2)))
			}

			it("adopts CollectionType") {
				expect(pt[0]).to(equal(pt.x))
				expect(pt[1]).to(equal(pt.y))
			}

			it("calculates magnitude") {
				expect(pt.magnitude).to(equal(5))
			}

			it("can add") {
				let pt2 = VectorType(collection: [1, -2])
				expect(pt + pt2).to(equal(VectorType(collection: [4, 2])))
			}

			it("can scale") {
				expect(pt * Float(3)).to(equal(VectorType(collection: [9, 12])))
				expect(pt * Float(-1)).to(equal(VectorType(collection: [-3, -4])))
			}

			it("can get unit vector") {
				expect(VectorType(collection: [10, 0]).unit).to(equal(VectorType(collection: [1, 0])))
				expect(VectorType(collection: [0, 10]).unit).to(equal(VectorType(collection: [0, 1])))

				let u = VectorType(collection: [3, 4]).unit
				expect(u.x).to(beCloseTo(0.6))
				expect(u.y).to(beCloseTo(0.8))
			}

			it("can negate") {
				expect(pt.negative).to(equal(VectorType(collection: [-pt.x, -pt.y])))
			}

			it("can subtract") {
				expect(pt - VectorType(collection: [-2, 4])).to(equal(VectorType(collection: [pt.x + 2, pt.y - 4])))
			}
		}
	}
}


class CustomVector3TypeSpec: QuickSpec {
	typealias VectorType = CustomVector3
	override func spec() {
		describe("Custom vectors") {
			let pt = VectorType(collection: [3, 4, 5])

			it("can initialize from collections") {
				expect(VectorType(collection: [1, 2, 3])).to(equal(VectorType(x: 1, y: 2, z: 3)))
				expect(VectorType(collection: [-1, -2, 3, 4])).to(equal(VectorType(x: -1, y: -2, z: 3)))
			}

			it("adopts CollectionType") {
				expect(pt[0]).to(equal(pt.x))
				expect(pt[1]).to(equal(pt.y))
				expect(pt[2]).to(equal(pt.z))
			}

			it("calculates magnitude") {
				expect(pt.magnitude).to(beCloseTo(5 * Float(2.0).toThePowerOf(0.5)))
			}

			it("can add") {
				let pt2 = VectorType(collection: [1, -2, 3])
				expect(pt + pt2).to(equal(VectorType(collection: [3 + 1, 4 + -2, 5 + 3])))
			}

			it("can scale") {
				expect(pt * Float(3)).to(equal(VectorType(collection: [9, 12, 15])))
				expect(pt * Float(-1)).to(equal(VectorType(collection: [-3, -4, -5])))
			}

			it("can get unit vector") {
				expect(VectorType(collection: [10, 0, 0]).unit).to(equal(VectorType(collection: [1, 0, 0])))
				expect(VectorType(collection: [0, 10, 0]).unit).to(equal(VectorType(collection: [0, 1, 0])))
				expect(VectorType(collection: [0, 0, 10]).unit).to(equal(VectorType(collection: [0, 0, 1])))

				let u = VectorType(collection: [3, 4, 5]).unit
				expect(u.x).to(beCloseTo(3.0 / (5.0 * pow(2.0, 0.5))))
				expect(u.y).to(beCloseTo(2.0 * pow(2.0, 0.5) / 5.0))
				expect(u.z).to(beCloseTo(1.0 / pow(2.0, 0.5)))
			}

			it("can negate") {
				expect(pt.negative).to(equal(VectorType(collection: [-pt.x, -pt.y, -pt.z])))
			}

			it("can subtract") {
				expect(pt - VectorType(collection: [-2, 4, 1])).to(equal(VectorType(collection: [pt.x + 2, pt.y - 4, pt.z - 1])))
			}
		}
	}
}