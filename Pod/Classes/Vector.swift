import Foundation

/// A dimensional data structure.
public protocol Vector: CollectionType, Ring {
	associatedtype Generator = IndexingGenerator<Self>

	/// The type which represents this vector type's length or magnitude.
	associatedtype LengthType

	/// Common initializer for vectors, allowing conversion among similar vector types.
	init<T where T: CollectionType, T.Generator.Element == Self.Generator.Element>(collection: T)

	/// How many dimensions does this vector have?
	static var numberOfDimensions: Int { get }

	/// The magnitude of the vector.
	var magnitude: LengthType { get }

	/// The squared magnitude of the vector.
	var squaredMagnitude: LengthType { get }

	/// A unit vector pointing in this vector's direction.
	var unit: Self { get }

	/// The negation of this vector, which points in the opposite direction as this vector, with an equal magnitude.
	var negative: Self { get }


	/// Produces a vector by translating this vector by `operand`.
	func sum(operand: Self) -> Self

	/// Produces a vector by translating one vector by another of a similar type.
	func sum<V: Vector where V.Generator.Element == Self.Generator.Element>(operand: V) -> Self

	/// Produces a vector by translating one vector by another of a similar type.
	func sum<V: Vector where V.Generator.Element == Self.Generator.Element>(operand: V) -> V


	/// Produces a vector by scaling this vector by a scalar.
	func scale(scalar: Self.Generator.Element) -> Self

	/// Produces a vector by performing a piecewise multiplication of this vector by another vector.
	func piecewiseMultiply(vector: Self) -> Self
	func piecewiseMultiply<V: Vector where V.Generator.Element == Self.Generator.Element>(vector: V) -> Self
	func piecewiseMultiply<V: Vector where V.Generator.Element == Self.Generator.Element>(vector: V) -> V


	// MARK: - Methods with default implementations

	/// Produces a vector by translating one vector by another.
	func + (randl: Self, randr: Self) -> Self
	func + <V: Vector where V.Generator.Element == Self.Generator.Element>(randl: Self, randr: V) -> Self
	func + <V: Vector where V.Generator.Element == Self.Generator.Element>(randl: Self, randr: V) -> V

	/// Produces a vector by scaling a vector by a scalar.
	func * (vector: Self, scalar: Self.Generator.Element) -> Self
	func * (scalar: Self.Generator.Element, vector: Self) -> Self

	/// Produces a vector by multiplying two vectors piecewise.
	func * (lhs: Self, rhs: Self) -> Self
	func * <V: Vector where V.Generator.Element == Self.Generator.Element>(lhs: Self, rhs: V) -> Self
	func * <V: Vector where V.Generator.Element == Self.Generator.Element>(lhs: Self, rhs: V) -> V

	/// Produces a vector by translating the right-hand vector by the negation of the left-hand vector.
	func - (randl: Self, randr: Self) -> Self
	func - <V: Vector where V.Generator.Element == Self.Generator.Element>(randl: Self, randr: V) -> Self
	func - <V: Vector where V.Generator.Element == Self.Generator.Element>(randl: Self, randr: V) -> V

	/// Negates a vector.
	prefix func - (rand: Self) -> Self
}


// MARK: - Aliases

public extension Vector {
	public var normalized: Self {
		return self.unit
	}

	public var length: Self.LengthType {
		return self.magnitude
	}

	public func distanceTo(vector: Self) -> Self.LengthType {
		return (vector - self).magnitude
	}

	public func distanceTo<V: Vector where V.Generator.Element == Self.Generator.Element>(vector: V) -> Self.LengthType {
		return self.distanceTo(Self(collection: vector))
	}
}


// MARK: - Default implementations

public extension Vector {
	public func generate() -> IndexingGenerator<Self> {
		return IndexingGenerator(self)
	}
}

public extension Vector where Self.Index == Int {
	public var startIndex: Int {
		return 0
	}

	public var endIndex: Int {
		return self.dynamicType.numberOfDimensions
	}
}

public extension Vector where Self.Generator.Element: Ring {
	public static var additionIdentity: Self {
		return Self(collection: Array(count: Self.numberOfDimensions, repeatedValue: Self.Generator.Element.additionIdentity))
	}
	public static var multiplicationIdentity: Self {
		return Self(collection: Array(count: Self.numberOfDimensions, repeatedValue: Self.Generator.Element.multiplicationIdentity))
	}
}

public func + <V: Vector> (randl: V, randr: V) -> V {
	return randl.sum(randr)
}

public func + <V1: Vector, V2: Vector where V1.Generator.Element == V2.Generator.Element> (randl: V1, randr: V2) -> V1 {
	return randl.sum(randr)
}

public func + <V1: Vector, V2: Vector where V1.Generator.Element == V2.Generator.Element> (randl: V1, randr: V2) -> V2 {
	return randl.sum(randr)
}


public func * <V: Vector> (vector: V, scalar: V.Generator.Element) -> V {
	return vector.scale(scalar)
}

public func * <V: Vector> (scalar: V.Generator.Element, vector: V) -> V {
	return vector.scale(scalar)
}


public func * <V: Vector>(randl: V, randr: V) -> V {
	return randl.piecewiseMultiply(randr)
}

public func * <V1: Vector, V2: Vector where V1.Generator.Element == V2.Generator.Element> (randl: V1, randr: V2) -> V1 {
	return randl.piecewiseMultiply(randr)
}

public func * <V1: Vector, V2: Vector where V1.Generator.Element == V2.Generator.Element> (randl: V1, randr: V2) -> V2 {
	return randl.piecewiseMultiply(randr)
}


public func - <V: Vector>(randl: V, randr: V) -> V {
	return randl.sum(randr.negative)
}

public func - <V1: Vector, V2: Vector where V1.Generator.Element == V2.Generator.Element> (randl: V1, randr: V2) -> V1 {
	return randl.sum(randr.negative)
}

public func - <V1: Vector, V2: Vector where V1.Generator.Element == V2.Generator.Element> (randl: V1, randr: V2) -> V2 {
	return randl.sum(randr.negative)
}


public prefix func - <V: Vector>(rand: V) -> V {
	return rand.negative
}


public extension Vector where Self: Equatable, Self.Generator.Element: Equatable {}
public func == <V: Vector where V.Generator.Element: Equatable>(lhs: V, rhs: V) -> Bool {
	if lhs.count != rhs.count {
		return false
	}

	return zip(lhs, rhs)
		.map { $0.0 == $0.1 }
		.reduce(true) { $0 && $1 }
}


// MARK: - Default implementations for specific element types

public extension Vector where Self.Generator.Element: Ring {
	public func sum(operand: Self) -> Self {
		return self.dynamicType.init(collection: Array(zip(self, operand).map { $0 + $1 }))
	}

	public func sum<V: Vector where V.Generator.Element == Self.Generator.Element>(operand: V) -> Self {
		return self.dynamicType.init(collection: Array(zip(self, operand).map { $0 + $1 }))
	}

	public func sum<V: Vector where V.Generator.Element == Self.Generator.Element>(operand: V) -> V {
		return V(collection: Array(zip(self, operand).map { $0 + $1 }))
	}

	public func scale(scalar: Self.Generator.Element) -> Self {
		return self.dynamicType.init(collection: self.map { $0 * scalar })
	}

	public func piecewiseMultiply(vector: Self) -> Self {
		return Self(collection: zip(self, vector).map { (lhs, rhs) in lhs * rhs })
	}

	public func piecewiseMultiply <V: Vector where V.Generator.Element == Self.Generator.Element> (vector: V) -> Self {
		return Self(collection: zip(self, vector).map { (lhs, rhs) in lhs * rhs })
	}

	public func piecewiseMultiply <V: Vector where V.Generator.Element == Self.Generator.Element> (vector: V) -> V {
		return V(collection: zip(self, vector).map { (lhs, rhs) in lhs * rhs })
	}

	public var squaredMagnitude: Self.Generator.Element {
		return self.reduce(Self.Generator.Element.additionIdentity) { $0 + $1 * $1 }
	}
}

public extension Vector where Generator.Element: Field, LengthType == Self.Generator.Element {
	public var magnitude: LengthType {
		return self.squaredMagnitude.toThePowerOf(0.5)
	}

	public var unit: Self {
		return self * (self.dynamicType.LengthType.multiplicationIdentity / self.magnitude)
	}

	public var negative: Self {
		return self * -1.0
	}
}