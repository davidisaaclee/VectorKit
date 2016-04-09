//
//  CustomVectors.swift
//  VectorKit
//
//  Created by David Lee on 4/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import VectorKit


extension Float: Field {
	public static let additionIdentity: Float = 0
	public static let multiplicationIdentity: Float = 1

	public func toThePowerOf(exponent: Float) -> Float {
		return powf(self, exponent)
	}
}


public final class CustomVector2 {
	let x: Float
	let y: Float

	public init(x: Float, y: Float) {
		self.x = x
		self.y = y
	}

	public convenience init<T where T: CollectionType, T.Generator.Element == Float>(collection: T) {
		var g = collection.generate()
		guard let x = g.next(), let y = g.next() else {
			fatalError()
		}
		self.init(x: x, y: y)
	}
}

extension CustomVector2: Vector {
	public typealias Index = Int

	public static let additionIdentity: CustomVector2 = CustomVector2(collection: [0, 0])
	public static let multiplicationIdentity: CustomVector2 = CustomVector2(collection: [1, 1])

	public var numberOfDimensions: Int { return 2 }

	public subscript(index: Int) -> Float {
		switch index {
		case 0:
			return x
		case 1:
			return y
		default:
			fatalError()
		}
	}
}

extension CustomVector2: Equatable {}


public struct CustomVector3 {
	let x: Float
	let y: Float
	let z: Float

	public init(x: Float, y: Float, z: Float) {
		self.x = x
		self.y = y
		self.z = z
	}

	public init<T where T: CollectionType, T.Generator.Element == Float>(collection: T) {
		var g = collection.generate()
		guard let x = g.next(), let y = g.next(), let z = g.next() else {
			fatalError()
		}
		self.init(x: x, y: y, z: z)
	}
}

extension CustomVector3: Vector {
	public typealias Index = Int

	public static let additionIdentity: CustomVector3 = CustomVector3(collection: [0, 0, 0])
	public static let multiplicationIdentity: CustomVector3 = CustomVector3(collection: [1, 1, 1])

	public var numberOfDimensions: Int { return 3 }

	public subscript(index: Int) -> Float {
		switch index {
		case 0:
			return self.x
		case 1:
			return self.y
		case 2:
			return self.z
		default:
			fatalError()
		}
	}
}

extension CustomVector3: Equatable {}