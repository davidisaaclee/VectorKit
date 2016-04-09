import Foundation

/// A set which defines addition and multiplication operations, as well as identity values for each of those operations.
public protocol Ring {
	static var additionIdentity: Self { get }
	static var multiplicationIdentity: Self { get }

	func + (randl: Self, randr: Self) -> Self
	func * (randl: Self, randr: Self) -> Self
}

/**
 A set which defines closed addition, multiplication, subtraction, and division operations satisfying the appropriate
 abelian group equations and distributive law.
*/
public protocol Field: Ring, FloatLiteralConvertible {
	func - (randl: Self, randr: Self) -> Self
	func / (randl: Self, randr: Self) -> Self

	// Not a real field operation...
	func toThePowerOf(exponent: Self) -> Self
}