extends Node

func enable_bit(bits: int, index: int) -> int:
	return bits | (1 << index)

func disable_bit(bits: int, index: int) -> int:
	return bits & ~(1 << index)
